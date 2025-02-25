local get_root_folder = require('helpers.get-root-folder')

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

      function _LAZYGIT_TOGGLE()
        local root = get_root_folder()
        local lazygit_cmd = 'lazygit'
        if root then
          lazygit_cmd = string.format('lazygit --path=%s', vim.fn.fnameescape(root))
        end
        local lazygit = Terminal:new({ cmd = lazygit_cmd, display_name = "lazygit", hidden = true, direction = "float" })
        lazygit:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle lazygit" })

      local python = Terminal:new({ cmd = "python", display_name = "python REPL", hidden = true, direction = "float" })
      function _PYTHON_TOGGLE()
        python:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle python" })

      local node = Terminal:new({ cmd = "node", display_name = "node REPL", hidden = true, direction = "float" })
      function _NODE_TOGGLE()
        node:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>lj", "<cmd>lua _NODE_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle node" })

      local ncdu = Terminal:new({ cmd = "ncdu", display_name = "ncdu", hidden = true, direction = "float" })
      function _NCDU_TOGGLE()
        ncdu:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>ln", "<cmd>lua _NCDU_TOGGLE()<CR>", { noremap = true, silent = true, desc = "Toggle ncdu" })

    end,
  }
}
