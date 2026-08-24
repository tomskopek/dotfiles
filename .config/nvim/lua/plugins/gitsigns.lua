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
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next [H]unk" })

          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Previous [H]unk" })

          map("n", "<leader>gb", gitsigns.blame, {
            desc = "[G]it [B]lame",
          })

          map("n", "<leader>gr", gitsigns.reset_hunk, {
            desc = "[G]it [R]eset hunk",
          })
        end,
      })

      -- Toggle the hunk base between the index (default) and the merge-base
      -- with main: gutters then show everything the branch changed vs main,
      -- including already-committed work, and ]h/[h navigate those hunks.
      -- Merge-base (not main itself) so commits main gained since branching
      -- don't show up as hunks — same semantics as a GitHub PR diff.
      -- NOTE: while toggled, <leader>gr resets hunks to the merge-base version.
      vim.keymap.set("n", "<leader>gm", function()
        local gitsigns = require("gitsigns")
        if vim.g.gitsigns_base_is_main then
          gitsigns.change_base(nil, true)
          vim.g.gitsigns_base_is_main = false
          vim.notify("gitsigns: hunks vs index")
          return
        end
        local base, ref = require("functions.git-main-merge-base")(vim.fn.expand("%:p:h"))
        if not base then
          vim.notify("gitsigns: no main/master branch found", vim.log.levels.WARN)
          return
        end
        gitsigns.change_base(base, true)
        vim.g.gitsigns_base_is_main = true
        vim.notify(("gitsigns: hunks vs %s (merge-base %s)"):format(ref, base:sub(1, 7)))
      end, { desc = "[G]it toggle hunks vs [M]ain" })
    end,
  },
}
