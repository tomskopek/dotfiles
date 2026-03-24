-- Hint: To discover _where_ a keymap is being set:
-- :verbose map <leader>ev

-- Buffers
vim.keymap.set("n", "<leader>x", function()
  local buf = vim.api.nvim_get_current_buf()
  -- Switch to previous buffer first so nvim-tree doesn't fill the window
  if vim.fn.buflisted(vim.fn.bufnr("#")) == 1 then
    vim.cmd("b#")
  else
    vim.cmd("bprev")
  end
  -- If we're still on the same buffer (no other listed buffer), just delete
  if vim.api.nvim_get_current_buf() == buf then
    vim.cmd("bd")
  else
    vim.cmd("bd " .. buf)
  end
end, { silent = true, desc = "[x] Close Current Buffer" })
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

vim.keymap.set("n", "<leader>yrf", function()
  vim.fn.setreg("+", vim.fn.expand("%:p:."))
end, { silent = true, desc = "[Y]ank [R]elative [F]ile path to clipboard" })

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
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]o to [I]mplementation' })

-- show error under cursor
vim.keymap.set("n", "<leader>er", function()
  vim.diagnostic.open_float(nil, { focusable = true, border = "rounded" })
end, { desc = "Show diagnostics/[E][R]rors in a floating window" })

-- Quickfix
-- --------
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "[Q]uickfix next" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "[Q]uickfix prev" })
local function qf_is_open()
  return vim.fn.getqflist({ winid = 0 }).winid ~= 0
end
vim.keymap.set("n", "<C-q>", function()
  vim.cmd(qf_is_open() and "cclose" or "copen")
end, { desc = "Toggle [Q]uickfix window" })
vim.keymap.set("n", "<C-c>", function()
  -- Close side windows one at a time: git blame, fugitive diff, quickfix, nvim-tree
  if require("functions.close-git-blame")() then
    return
  end
  if vim.wo.diff then
    require("functions.close-fugitive-diff")()
    return
  end
  if qf_is_open() then
    vim.cmd("cclose")
    return
  end
  local ok, api = pcall(require, "nvim-tree.api")
  if ok and api.tree.is_visible() then
    api.tree.close()
    return
  end
end, { desc = "[C]lose side windows (fugitive diff, quickfix, nvim-tree)" })

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

-- notes.md (useful for jotting down notes!)
vim.keymap.set("n", "<leader>on", ":e ~/notes.md<CR>")
vim.keymap.set("n", "<leader>os", ":e ~/scratch.md<CR>")

-- No-ops
vim.keymap.set("v", "K", "<Nop>", { silent = true }) -- not unusual to misclick this (ctrl+v to select line, k to move up). capital K brings up documentation and this fails with visual line selected
