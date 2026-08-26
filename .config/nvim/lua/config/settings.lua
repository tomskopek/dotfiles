-- Set <space> as the leader key.
-- Must happen before plugins are required (otherwise the wrong leader will be used).
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
vim.opt.number = true -- Absolute line numbers in the gutter
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.termguicolors = true -- Enable true color support (better color rendering in terminals that support it)
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.virtualedit = "block" -- In Visual block mode, cursor can be positioned anywhere (even if there is no character there)
vim.opt.signcolumn = "yes" -- Keep the sign column always open

-- Visual indicators
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.list = true -- Show listchars
vim.opt.listchars = "trail:·" -- Trailing spaces are represented as ·

-- Tabs
vim.opt.expandtab = true -- Spaces instead of tabs
vim.opt.shiftwidth = 2 -- Number of spaces for each indentation level
vim.opt.tabstop = 2 -- Number of spaces a tab character represents

-- Use system clipboard
--   Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Search
vim.opt.incsearch = true -- Find next match as we type
vim.opt.hlsearch = true -- Highlight searches by default
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true -- ...unless we type a capital

-- Scrolling
vim.opt.scrolloff = 8 -- Start scrolling when 8 lines from margin
vim.opt.sidescrolloff = 15 -- Start scrolling horizontally 15 lines from edge
vim.opt.sidescroll = 1 -- Scroll horizontally 1 char at a time (for smooth scrolling)

-- Screen split
vim.opt.splitbelow = true -- Horizontal split appears from below (eg. :help)
vim.opt.splitright = true
vim.opt.inccommand = "split" -- Show the effect of :%s in a split

-- Disable for clumsy fingers
vim.keymap.set("n", "q:", "<Nop>") -- Disable the command-line window

-- Folds
vim.opt.foldlevelstart = 99

-- keep n/N consistent whether using #/*
vim.keymap.set("n", "#", "*NN")

-- no swap files
vim.opt.swapfile = false

-- Quickfix window behavior:
--   buflisted=false: hide from buffer lists (Telescope, bufferline, :bnext)
--   winfixbuf=true:  lock window to its buffer so other buffers can't open in it
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.bo.buflisted = false
    vim.wo.winfixbuf = true
  end,
})

-- Auto-close the quickfix/location-list window when it's the last non-floating
-- window left (e.g. :q from the main window with quickfix still open).
-- Same pattern as the NvimTree auto-close in plugins/nvim-tree.lua.
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    local non_floating = 0
    for _, w in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(w).relative == "" then
        non_floating = non_floating + 1
      end
    end
    if non_floating == 1 and vim.bo.buftype == "quickfix" then
      vim.cmd("quit")
    end
  end,
})
