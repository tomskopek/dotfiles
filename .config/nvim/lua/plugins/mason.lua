return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- LSP servers to auto-install
      ensure_installed = {
        "ts_ls",
        "lua_ls",
        "basedpyright",
        "ruff",
      },
      automatic_installation = true,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Formatters and other tools to auto-install
      ensure_installed = {
        "stylua",
        "prettierd",
        "prettier",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
