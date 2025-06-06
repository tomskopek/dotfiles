-- TMUX integration
return {
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1

      -- Manually set keybindings, excluding Ctrl+\
      vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
      vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
      vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
      vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
    end,
  },
}
