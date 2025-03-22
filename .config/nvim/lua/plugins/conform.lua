return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "isort" }, -- Conform will run multiple formatters sequentially
        javascript = { "prettierd", "prettier", stop_after_first = true }, -- Conform will run the first available formatter
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      },
    },
    keys = {
      {
        "<leader>p",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
  },
}

-- to see a list of available formatters, check here
-- https://github.com/stevearc/conform.nvim/tree/master/lua/conform/formatters
