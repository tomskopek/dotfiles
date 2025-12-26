-- Python Language Server Configuration (basedpyright)
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      typeCheckingMode = "off", -- basic type checking (off/basic/strict)
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.enable('basedpyright')