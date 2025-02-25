-- Fuzzy Finder
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Use fzf for fuzzy matching
  },
  keys = {
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
    { "<C-b>", "<cmd>Telescope buffers<cr>", desc = "[S]earch [B]uffers" },
    { "\\", "<cmd>Telescope live_grep<cr>", desc = "Grep search" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "[S]earch [J]umplist" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]eymaps" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[S]earch [C]ommand History" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "%.git/", "node_modules/" },
        path_display = { "truncate" }, -- When filenames are too long, truncate the start of the path
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--type", "d" }, -- Inlcude both files and folders
        },
        buffers = {
          sort_mru = true, -- Sort by most recently used
          ignore_current_buffer = true, -- Don't show the current buffer
        },
      },
    })

    telescope.load_extension("fzf")

    local builtin = require("telescope.builtin")

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>ev", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[E]dit neo[V]im files" })
  end,
}
