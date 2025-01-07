-- Fuzzy Finder
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", '<cmd>Telescope find_files<cr>', desc = 'File search' },
      { "<C-b>", '<cmd>Telescope buffers<cr>', desc = 'Search buffers' },
      { "<leader>tg", '<cmd>Telescope live_grep<cr>', desc = 'Grep search' },
      { "<leader>tj", '<cmd>Telescope jumplist<cr>', desc = 'Search jumplist' },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          buffers = {
            sort_mru = true,  -- Sort by most recently used
            ignore_current_buffer = true,  -- Don't show the current buffer
          }
        }
      })
    end,
  },
}
