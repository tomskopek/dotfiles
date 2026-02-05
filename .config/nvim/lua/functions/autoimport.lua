-- NOTE: THIS FILE WAS VIBE CODED
-- Auto-import: uses LSP completions to find and add imports for symbol under cursor

-- Simple floating picker using native nvim API
local function floating_select(items, opts, on_choice)
  local lines = {}
  for i, item in ipairs(items) do
    lines[i] = string.format(" %d. %s", i, opts.format_item(item))
  end

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  -- Calculate window size and position
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, #line)
  end
  width = math.min(width + 2, math.floor(vim.o.columns * 0.8))
  local height = math.min(#lines, 10)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    row = 1,
    col = 0,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    title = " " .. (opts.prompt or "Select") .. " ",
    title_pos = "center",
  })

  -- Highlight current line
  vim.api.nvim_set_option_value("cursorline", true, { win = win })

  local function close_and_select(idx)
    vim.api.nvim_win_close(win, true)
    if idx and items[idx] then
      on_choice(items[idx])
    else
      on_choice(nil)
    end
  end

  -- Keymaps for selection
  local kopts = { buffer = buf, nowait = true }
  vim.keymap.set("n", "<CR>", function()
    local idx = vim.api.nvim_win_get_cursor(win)[1]
    close_and_select(idx)
  end, kopts)
  vim.keymap.set("n", "<Esc>", function() close_and_select(nil) end, kopts)
  vim.keymap.set("n", "q", function() close_and_select(nil) end, kopts)

  -- Number keys for quick select
  for i = 1, math.min(#items, 9) do
    vim.keymap.set("n", tostring(i), function() close_and_select(i) end, kopts)
  end
end

local function auto_import()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    vim.notify("No word under cursor")
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  -- Find where the word ends on the current line
  local col = cursor[2]
  local word_start = col
  local word_end = col

  -- Find start of word
  while word_start > 0 and line:sub(word_start, word_start):match("[%w_]") do
    word_start = word_start - 1
  end

  -- Find end of word
  while word_end <= #line and line:sub(word_end + 1, word_end + 1):match("[%w_]") do
    word_end = word_end + 1
  end

  local params = {
    textDocument = vim.lsp.util.make_text_document_params(bufnr),
    position = { line = cursor[1] - 1, character = word_end },
  }

  -- Use buf_request_all to wait for all LSPs to respond
  vim.lsp.buf_request_all(bufnr, "textDocument/completion", params, function(results)
    local import_items = {}

    for _, result in pairs(results) do
      if result.result then
        local items = result.result.items or result.result
        for _, item in ipairs(items) do
          if item.label == word and item.additionalTextEdits and #item.additionalTextEdits > 0 then
            table.insert(import_items, item)
          end
        end
      end
    end

    if #import_items == 0 then
      -- Fallback: try code actions (for TypeScript and other LSPs)
      local function is_import_action(action)
        if action.kind == "quickfix" and action.command and action.command.arguments then
          local args = action.command.arguments[1]
          if args then
            if args.fixName == "import" then return true end
            if args.action and args.action.fixName == "import" then return true end
          end
        end
        if action.title and action.title:lower():find("import") then
          return true
        end
        return false
      end

      -- Convert vim.diagnostic format to LSP diagnostic format
      local function to_lsp_diagnostic(d)
        return {
          range = {
            start = { line = d.lnum, character = d.col },
            ["end"] = { line = d.end_lnum or d.lnum, character = d.end_col or d.col },
          },
          message = d.message,
          severity = d.severity,
          source = d.source,
          code = d.code,
        }
      end

      local lsp_diagnostics = {}
      for _, d in ipairs(vim.diagnostic.get(bufnr, { lnum = cursor[1] - 1 })) do
        table.insert(lsp_diagnostics, to_lsp_diagnostic(d))
      end

      local ca_params = vim.lsp.util.make_range_params(0, "utf-8")
      ca_params.context = { diagnostics = lsp_diagnostics }

      vim.lsp.buf_request_all(bufnr, "textDocument/codeAction", ca_params, function(results)
        local actions = {}
        local seen_titles = {}
        for client_id, result in pairs(results) do
          if result.result then
            for _, action in ipairs(result.result) do
              if is_import_action(action) and not seen_titles[action.title] then
                seen_titles[action.title] = true
                action._client_id = client_id
                table.insert(actions, action)
              end
            end
          end
        end

        if #actions == 0 then
          vim.notify("No import found for " .. word)
          return
        end

        local function apply_action(action)
          local client = vim.lsp.get_client_by_id(action._client_id)
          if not client then return end

          -- Resolve the action if needed (some servers require this)
          local function do_apply(resolved)
            if resolved.edit then
              vim.lsp.util.apply_workspace_edit(resolved.edit, client.offset_encoding)
            end
            if resolved.command then
              client.request("workspace/executeCommand", resolved.command, nil, bufnr)
            end
          end

          -- Check if action needs resolving
          if not action.edit and not action.command and action.data then
            client.request("codeAction/resolve", action, function(err, resolved)
              if resolved then do_apply(resolved) end
            end, bufnr)
          else
            do_apply(action)
          end
        end

        if #actions == 1 then
          apply_action(actions[1])
        else
          floating_select(actions, {
            prompt = "Import " .. word,
            format_item = function(action)
              return action.title or "Import"
            end,
          }, function(action)
            if action then apply_action(action) end
          end)
        end
      end)
      return
    end

    local function apply_import(item)
      vim.lsp.util.apply_text_edits(item.additionalTextEdits, bufnr, "utf-8")
      -- Show what was imported (use labelDetails if available)
      local desc = item.labelDetails and item.labelDetails.description or ""
      if desc ~= "" then
        vim.notify("Imported " .. word .. " from " .. desc)
      else
        vim.notify("Imported " .. word)
      end
    end

    if #import_items == 1 then
      apply_import(import_items[1])
    else
      floating_select(import_items, {
        prompt = "Import " .. word,
        format_item = function(item)
          local desc = item.labelDetails and item.labelDetails.description or ""
          if desc ~= "" then
            return desc
          end
          -- Fallback to showing the edit text
          local edit = item.additionalTextEdits[1]
          return edit.newText:gsub("^%s+", ""):gsub("%s+$", "")
        end,
      }, function(item)
        if item then
          apply_import(item)
        end
      end)
    end
  end)
end

vim.keymap.set("n", "<leader>a", auto_import, { desc = "[A]uto-import symbol under cursor" })
