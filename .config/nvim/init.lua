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
-- remove false python import errors: ■ Import "django.db.models.expressions" could not be resolved
--    └─ This probably has something to do with conda environment?
-- Prettier (auto format)	conform.vim
-- Copilot
-- snippets - eg: expand ipdb, console.log, function() {}, etc etc


-- Nice to haves:
-- -------------
-- Autocomplete braces
-- I feel like indentation is not great? Need to study this some more and understand what actually needs to be improved
-- Documentation for word under cursor with ctrl+k
-- there's a bit of lag when lsp servers starting up?
-- Update dotfiles readme for setting up a new laptop


-- Try these out:
-- --------------
--
-- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L166-L167
-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L169-L175
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
