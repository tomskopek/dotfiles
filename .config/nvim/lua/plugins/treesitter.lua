-- Syntax highlighting, based on a "tree-like" understanding of the code.
-- This is better than regex, which is the default way
-- And a bit more? https://www.reddit.com/r/neovim/comments/15jxqgn/i_dont_get_why_treesitter_is_a_big_deal_and_at/

return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      ---@diagnostic disable-next-line: missing-fields
      configs.setup({
        ensure_installed = {
          "c", -- required for nvim-treesitter
          "lua", -- required for nvim-treesitter
          "vim", -- required for nvim-treesitter
          "vimdoc", -- required for nvim-treesitter
          "query", -- required for nvim-treesitter
          "markdown", -- required for nvim-treesitter
          "markdown_inline", -- required for nvim-treesitter
          "python",
          "javascript",
          "typescript",
          "tsx",
          "html",
        },

        sync_install = false,

        auto_install = false, -- If you enter a file for which you don't have a parser installed yet, install the corresponding parser

        highlight = {
          enable = true,
          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          -- This fixes an issue where comments with non-matching braces
          --   mess up indentation in python
          --   see: https://github.com/nvim-treesitter/nvim-treesitter/issues/1573
          additional_vim_regex_highlighting = { "python" },
        },

        indent = {
          -- TODO: Better understand how this conflicts with nvim's default
          --   filetype-based indentation
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>ss",
            node_incremental = "<leader>si",
            scope_incremental = "<leader>sc",
            node_decremental = "<leader>sd",
          },
        },

        textobjects = {
          -- This is a great tutorial:
          --   https://www.youtube.com/watch?v=ff0GYrK3nT0&list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft&index=5
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "v",
              ["@class.outer"] = "<c-v>",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- With this, you can use ctrl+o to go back (like other jump movements, like gg/G for example)
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]t"] = "@tag.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]T"] = "@tag.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[t"] = "@tag.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[T"] = "@tag.outer",
            },
          },
        },
      })
    end,
  },
}

-- Useful commands
-- ---------------
-- :InspectTree (btw: this is a Treesitter engine command)
--     Inspect how treesitter sees your file
--
-- :TSBufEnable/Disable highlight/indent/etc
--     Enable/disable TreeSitter features. Useful for debugging
--
-- :TSEdityQuery highlights/textobjects/etc
--     Show queries for a given language
--
-- :highlight @function/@variable/etc
--     Trace how the highlight colors are defined, based on how Treesitter views words in the file
--     You may need to "follow the trail" eg :highlight @function -> :highlight Function
--
--
-- Common misconception: "you need nvim-treesitter for treesitter capability"
-- --------------------
-- In fact, nvim comes with treesitter _engine_ already installed
--   To verify this, you can disable nvim-treesitter and try :lua vim.print(vim.treesitter)
-- nvim-treesitter is a plugin that makes it easy to manage _parsers_
