return {
  {
    "jgdavey/tslime.vim",
    cmd = { "TslimeSend", "TslimeSendCurrentLine" },
    keys = {
      -- normal mode: send current line
      { "<leader>sl", "<Plug>NormalModeSendToTmux", mode = "n", desc = "[S]end [L]ine to tmux (t[SL]ime)" },
      -- visual mode: send selection
      { "<leader>sl",  "<Plug>SendSelectionToTmux", mode = "v", desc = "[S]end selection to tmux (t[SL]ime)" },
    },
    init = function()
      vim.g.tslime_always_current_session = 1
      vim.g.tslime_always_current_window = 1
      vim.g.tslime_autoset_pane = 1
    end,
  },
}
