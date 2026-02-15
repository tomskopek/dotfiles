return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Load conform right before I save the buffer (lazyloading)
    cmd = { "ConformInfo" }, -- or Load conform if I run ConformInfo command
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "autopep8", "ruff_format" }, -- Conform will run multiple formatters sequentially
        javascript = { "prettierd", "prettier", stop_after_first = true }, -- Conform will run the first available formatter
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
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
      {
        "<leader>cI",
        "<cmd>ConformInfo<cr>",
        desc = "Conform Info",
      },
    },
  },
}

-- to see a list of available formatters, check here
-- https://github.com/stevearc/conform.nvim/tree/master/lua/conform/formatters
