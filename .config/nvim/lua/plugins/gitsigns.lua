return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "]c next quickfix" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "[c previous quickfix" })

          map("n", "<leader>gd", gitsigns.preview_hunk, {
            desc = "[G]it [D]iff (preview hunk)",
          })

          map("n", "<leader>gb", gitsigns.blame, {
            desc = "[G]it [B]lame",
          })

          map("n", "<leader>gr", gitsigns.reset_hunk, {
            desc = "[G]it [R]eset hunk",
          })
        end,
      })
    end,
  },
}
