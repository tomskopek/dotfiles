-- File Explorer

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = true,
    keys = {
      { "<c-f>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
      { "<leader>f", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in File Explorer" },
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 50,
        },
      })

      -- Auto-close NvimTree when it's the last window.
      -- Source: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local tree_wins = {}
          local floating_wins = {}
          local wins = vim.api.nvim_list_wins()
          for _, w in ipairs(wins) do
            local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
            if bufname:match("NvimTree_") ~= nil then
              table.insert(tree_wins, w)
            end
            if vim.api.nvim_win_get_config(w).relative ~= "" then
              table.insert(floating_wins, w)
            end
          end
          if 1 == #wins - #floating_wins - #tree_wins then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(tree_wins) do
              vim.api.nvim_win_close(w, true)
            end
          end
        end,
      })
    end,
  },
}
