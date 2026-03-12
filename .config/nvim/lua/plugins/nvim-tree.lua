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

      -- Auto-close NvimTree when it's the last non-floating window
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          local wins = vim.api.nvim_list_wins()
          local non_floating = 0
          for _, w in ipairs(wins) do
            if vim.api.nvim_win_get_config(w).relative == "" then
              non_floating = non_floating + 1
            end
          end
          if non_floating == 1 and vim.bo.filetype == "NvimTree" then
            vim.cmd("quit")
          end
        end,
      })
    end,
  },
}
