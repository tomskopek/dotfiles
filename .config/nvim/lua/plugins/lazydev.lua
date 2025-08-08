-- properly configures lua_ls (lua language server)
return {
  {
    "folke/lazydev.nvim",
    enabled = true,
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
