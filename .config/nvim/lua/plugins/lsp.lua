return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { "williamboman/mason.nvim", },
      { "williamboman/mason-lspconfig.nvim", },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function (server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })

      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = false,  -- Disable inline diagnostics
        signs = {
          severity_sort = true,
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "", -- Disable "W" in the gutter
            [vim.diagnostic.severity.INFO] = "", -- Disable "I" in the gutter
            [vim.diagnostic.severity.HINT] = "", -- Disable "H" in the gutter
          },
        },
        underline = true,     -- Keep underlining the problems
        update_in_insert = false,
        severity_sort = true,
      })

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }, -- Supress "undefined global vim" warning
            },
          },
        },
      })

      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedVariable = "none" -- Disable "unused variable" hint
              },
            }
          }
        }
      })
    end,
  }
}

-- Useful Commands:
-- ---------------
--
-- :LspInfo while in a file
--     Checks if there is an lsp for that file, if it is running, etc
