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
    end,
  }
}

-- Useful Commands:
-- ---------------
--
-- :LspInfo while in a file
--     Checks if there is an lsp for that file, if it is running, etc
