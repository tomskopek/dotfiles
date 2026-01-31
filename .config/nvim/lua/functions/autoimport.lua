-- Auto-import: uses LSP completions to find and add imports for symbol under cursor
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
      vim.notify("No import found for " .. word)
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
      vim.ui.select(import_items, {
        prompt = "Select import for " .. word,
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
