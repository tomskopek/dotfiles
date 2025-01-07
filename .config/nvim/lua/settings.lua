-- Set <space> as the leader key.
-- Must happen before plugins are required (otherwise the wrong leader will be used).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Ensure clipboard works in tmux (is this necessary? Credit: ChatGPT)
if vim.fn.has("macunix") == 1 then
  vim.g.clipboard = {
    name = "tmux_clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 1,
  }
end
