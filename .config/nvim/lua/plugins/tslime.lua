return {
  {
    "jgdavey/tslime.vim",
    cmd = { "TslimeSend", "TslimeSendCurrentLine" },
    keys = {
      -- normal mode: send word under cursor
      {
        "<leader>sl",
        function()
          vim.fn.Send_to_Tmux(vim.fn.expand("<cword>") .. "\n")
        end,
        mode = "n",
        desc = "[S]end word under cursor to tmux (t[SL]ime)",
      },
      -- visual mode: send selection
      { "<leader>sl", "<Plug>SendSelectionToTmux", mode = "v", desc = "[S]end selection to tmux (t[SL]ime)" },
    },
    init = function()
      vim.g.tslime_always_current_session = 1
      vim.g.tslime_always_current_window = 1
      vim.g.tslime_autoset_pane = 1
    end,
  },
}
