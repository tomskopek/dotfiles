-- Hint: To discover _where_ a keymap is being set:
-- :verbose map <leader>ev

-- Buffers
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>", { silent = true, desc = "[x] Close Current Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprev<CR>", { silent = true, desc = "([) Previous [B]uffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { silent = true, desc = "(]) Next [B]uffer" })

vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "[Q] load the last [S]ession for the current directory" })

-- Formatting
vim.keymap.set("n", "<leader>cw", "m`:%s/\\s\\+$//e<CR>``", { silent = true, desc = "Clear trailing whitespaces" })

-- Yanking
vim.keymap.set("n", "<leader>yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { silent = true, desc = "[Y]ank full [F]ile path to clipboard" })

vim.keymap.set("n", "<leader>ydf", function()
  vim.fn.setreg("+", vim.fn.expand("%:r"):gsub("/", "."))
end, { silent = true, desc = "[Y]ank [D]otted relative [F]ile path to clipboard" })

-- Hint: To discover what other actions are possible for the word under cursor:
-- :lua vim.lsp.buf.code_action({ filter = function(a) print(vim.inspect(a)) return false end })
vim.keymap.set("n", "<leader>i", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind == "quickfix"
        and action.command
        and action.command.arguments
        and action.command.arguments[1]
        and action.command.arguments[1].fixName == "import"
    end,
    apply = true,
  })
end, { desc = "auto-[I]mport missing symbols", silent = true })

-- LSP navigation

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" })

-- show error under cursor
vim.keymap.set("n", "<leader>er", function()
  vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
end, { desc = "Show diagnostics/[E][R]rors in a floating window" })

-- Quickfix
-- --------
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "[Q]uickfix next" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "[Q]uickfix prev" })
vim.keymap.set("n", "<C-q>", function()
  local qf_exists = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end

  vim.notify(string.format("quickfix exists? [%s]", qf_exists))
end, { desc = "Toggle [Q]uickfix window" })

-- some tools for debugging syntax highlighting, maybe delete later
vim.keymap.set("n", "<leader>hi", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1] - 1
  local col = pos[2]

  -- Get treesitter highlights
  local ts_highlights = vim.treesitter.get_captures_at_pos(0, line, col)
  print("Treesitter highlights:", vim.inspect(ts_highlights))

  -- Get syntax highlights
  local syntax_id = vim.fn.synID(pos[1], col + 1, 1)
  local syntax_name = vim.fn.synIDattr(syntax_id, "name")
  print("Syntax highlight:", syntax_name)

  -- Get diagnostics
  local diagnostics = vim.diagnostic.get(0, { lnum = line })
  print("Diagnostics:", vim.inspect(diagnostics))
end)
vim.keymap.set("n", "<leader>tshi", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  local captures = vim.treesitter.get_captures_at_pos(bufnr, row, col)
  print(vim.inspect(captures))

  -- Also print the current highlight group
  local hl_group = vim.fn.synIDattr(vim.fn.synID(row + 1, col + 1, 1), "name")
  print("Current highlight group:", hl_group)

  -- Print the highlight attributes
  local hl_info = vim.api.nvim_get_hl(0, { name = hl_group })
  print("Highlight attributes:", vim.inspect(hl_info))
end)


