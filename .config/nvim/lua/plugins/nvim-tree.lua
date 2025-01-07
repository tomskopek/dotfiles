-- File Explorer

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
  { 
    "nvim-tree/nvim-tree.lua", 
    keys = {
      { "<leader>e", '<cmd>NvimTreeToggle<cr>', desc = 'Toggle File Explorer' },
      { "<leader>f", '<cmd>NvimTreeFindFile<cr>', desc = 'Find file in File Explorer' },
      -- { "<leader>f", function()
      --     local api = require("nvim-tree.api")
      --     if not api.tree.is_visible() then
      --       api.tree.open()
      --     end
      --     api.tree.find_file(true)
      --   end, desc = "Open File Explorer with current file focused" },
      --
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
}
