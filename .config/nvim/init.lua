require("config.settings")
require("config.keymaps")
require("config.lsp")
require("functions.redir")
require("functions.autoimport")
require("functions.references-no-imports")

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
    { import = "plugins" },
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
-- - Copilot
-- - Auto fix imports on command, or even better when I commit (is that possible to setup?)
-- - Go to definition not working for css (styles.xyz)
-- - Commenting out react components
--
-- Nice to haves:
-- -------------
-- - Open visually selected lines of code in github.com
-- - Update dotfiles readme for setting up a new laptop
-- - Multiple cursors
-- - Telescope nav search_history
--
-- Annoying things:
-- ----------------
-- - When I open toggleterm python or node, I can get into terminal "visual mode" sometimes (I'm not actually sure what it's called).
--     It's not exactly clear what fat fingers typo I did to get there and I can't find it now... But it's quite annoying, and
--     I don't know how to leave. I have to do :q and then exit vim session otherwise my python/node terminal is messed up
--        -> I figured it out! If you click away (to something outside of iterm2) and then click back in iterm2 with the python 
--            terminal open inside of nvim, this gets you into this mode. To exit this mode, press "i" (insert mode)
-- - When I open a folder in telescope, the project directory changes (:pwd shows the folder that I opened). This means I cannot
--     change find files using telescope anymore. I have to quit and reopen vim.
-- - sometimes I get into a funky state when quickfix or filetree is open, and I want to close current buffer. It's like the quickfix or filetree
--     "take over" the screen
-- - exiting telescope sucks. If I enter and type nothing, I'm in insert mode. I'd like to press esc to leave. I have to press ctrl+c or esc twice. 
--     But If I press esc once to go to normal mode, ctrl+c no longer exits.
--
-- Try these out:
-- --------------
--
-- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L166-L167
-- Diagnostic keymaps
--
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
--
--
-- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L169-L175
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
--
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
