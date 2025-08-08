-- Python Linting and Formatting (ruff)
vim.lsp.config('ruff', {
  settings = {
    lint = {
      enable = true,
    },
  },
})

vim.lsp.enable('ruff')