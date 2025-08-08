return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "j-hui/fidget.nvim", opts = { progress = { display = { done_ttl = 8 } } } },
    },
    config = function()
      -- Non-intrusive diagnostic configuration
      vim.diagnostic.config({
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
          },
        },
        virtual_text = false, -- No inline diagnostics to avoid "jumps"
        underline = true,
        float = {
          source = true,
          severity_sort = true,
          format = function(diagnostic)
            local severity_names = {
              [vim.diagnostic.severity.ERROR] = "Error",
              [vim.diagnostic.severity.WARN] = "Warn",
              [vim.diagnostic.severity.INFO] = "Info",
              [vim.diagnostic.severity.HINT] = "Hint",
            }
            local severity = severity_names[diagnostic.severity] or "Unknown"
            return string.format("[%s] %s", severity, diagnostic.message)
          end,
        },
      })
    end,
  },
}
