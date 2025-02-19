-- Fuzzy Finder
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } -- Use fzf for fuzzy matching
  },
  keys = {
    { "<C-p>", '<cmd>Telescope find_files<cr>', desc = 'File search' },
    { "<C-b>", '<cmd>Telescope buffers<cr>', desc = 'Search buffers' },
    { "<leader>sh", '<cmd>Telescope help_tags<cr>', desc = 'Search docs' },
    { "\\", '<cmd>Telescope live_grep<cr>', desc = 'Grep search' },
    { "<leader>sj", '<cmd>Telescope jumplist<cr>', desc = 'Search jumplist' },
    { "<leader>sk", '<cmd>Telescope keymaps<cr>', desc = 'Search jumplist' },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "%.git/", "node_modules/" },
        path_display = { "truncate", }, -- When filenames are too long, truncate the start of the path
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--type", "d" } -- Inlcude both files and folders
        },
        buffers = {
          sort_mru = true,  -- Sort by most recently used
          ignore_current_buffer = true,  -- Don't show the current buffer
        }
      }
    })
    telescope.load_extension("fzf")
  end,
}
