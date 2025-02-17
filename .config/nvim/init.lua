require 'settings'
require 'keymaps'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins using lazy.nvim
require("lazy").setup({
  spec = {
    { import = 'plugins' },
  },
  change_detection = {
    notify = false, -- this notification that "config change detected" is annoying, and it doesn't seem to... do anything?
  },
})

vim.cmd.colorscheme("kanagawa")


-- TODO:
--
-- Must haves:
-- ----------
-- Error highlighting	lsp ✅
-- Grep text with "\" ✅
-- "Go to def" keyboard shortcut ✅
-- "Find usages" ✅
-- Auto imports using lsp
-- Prettier (auto format)	conform.vim
-- Copilot
-- clever console.log snippets
-- ipdb snippet

-- Nice to haves:
-- -------------
-- Documentation for word under cursor with ctrl+k
-- nvim-tree is very laggy...
-- there's a bit of lag when lsp servers starting up?
