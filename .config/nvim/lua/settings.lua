-- Set <space> as the leader key.
-- Must happen before plugins are required (otherwise the wrong leader will be used).
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
vim.opt.number = true -- Absolute line numbers in the gutter
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.expandtab = true -- Spaces instead of tabs
vim.opt.shiftwidth = 2 -- Number of spaces for each indentation level
vim.opt.tabstop = 2 -- Number of spaces a tab character represents
vim.opt.termguicolors = true -- Enable true color support (better color rendering in terminals that support it)
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.virtualedit = "block" -- In Visual block mode, cursor can be positioned anywhere (even if there is no character there)

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

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

-- Misc
vim.keymap.set("n", "q:", "<Nop>") -- Disable the command-line window
