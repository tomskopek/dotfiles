-- Fuzzy Finder
return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- Use fzf for fuzzy matching
    { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" }, -- Refine live_grep with ripgrep args
    { "kkharji/sqlite.lua" }, -- Required for telescope-smart-history
    { "nvim-telescope/telescope-smart-history.nvim" }, -- Context aware search history (switching projects gives different history)
  },
  keys = {
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
    { "<C-b>", "<cmd>Telescope buffers<cr>", desc = "[S]earch [B]uffers" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
    { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "[S]earch [J]umplist" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]eymaps" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[S]earch [C]ommand History" },
  },
  config = function()
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { "%.git/", "node_modules/" },
        preview = false,
        path_display = { "truncate" }, -- When filenames are too long, truncate the start of the path
        prompt_prefix = "",
        mappings = {
          i = {
            ["<C-h>"] = require("telescope.actions").preview_scrolling_left,
            ["<C-j>"] = require("telescope.actions").preview_scrolling_down,
            ["<C-k>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-l>"] = require("telescope.actions").preview_scrolling_right,
            ["<C-f>"] = require("telescope.actions").to_fuzzy_refine,
            ["<C-]>"] = require("telescope.actions").cycle_history_next,
            ["<C-[>"] = require("telescope.actions").cycle_history_prev,
          },
        },
        history = {
          -- telescope-smart-history
          path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
          limit = 100,
        }
      },
      pickers = {
        buffers = {
          sort_mru = true, -- Sort by most recently used
          ignore_current_buffer = true, -- Don't show the current buffer
        },
        find_files = {
          -- find_command = { "fd", "--type", "f" }, -- Use fd, DONT include hidden files
          find_command = { "fd", "--type", "f", "--hidden" }, -- Use fd, include hidden files
        },
      },
      extensions = {
        live_grep_args = {
          -- auto_quoting = false, -- if set to false == automatically quote the first word
          mappings = {
            i = {
              ["<C-u>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            },
          },
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("smart_history")

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "\\", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {
      desc = "[\\] Grep",
    })

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

    vim.keymap.set("n", "<leader>sv", function()
      builtin.live_grep({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]dit neo[V]im files" })
  end,
}
