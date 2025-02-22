return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function ()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        close_on_exit = true,
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local lazygit = Terminal:new({ cmd = "lazygit", display_name = "lazygit", hidden = true, direction = "float" })
      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle lazygit" })

      local python = Terminal:new({ cmd = "python", display_name = "python REPL", hidden = true, direction = "float" })
      function _PYTHON_TOGGLE()
        python:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle python" })

      local ncdu = Terminal:new({ cmd = "ncdu", display_name = "ncdu", hidden = true, direction = "float" })
      function _NCDU_TOGGLE()
        ncdu:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>ln", "<cmd>lua _NCDU_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle ncdu" })

    end,
  }
}
