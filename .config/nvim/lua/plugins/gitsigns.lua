return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Set before setup(): the first buffer can attach during setup itself.
      vim.g.gitsigns_base_is_main = true

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

      -- Default base: merge-base with main, per buffer's repo. Gutters show
      -- everything the branch changed vs main, including committed work
      -- (GitHub-PR-diff semantics). <leader>gm toggles back to vs-index.
      vim.api.nvim_create_autocmd("User", {
        pattern = "GitSignsUpdate",
        callback = function(args)
          if not vim.g.gitsigns_base_is_main then
            return
          end
          local bufnr = (args.data and args.data.buffer) or args.buf
          if not vim.api.nvim_buf_is_valid(bufnr) or vim.b[bufnr].gitsigns_main_base_applied then
            return
          end
          -- The first update event fires before attach completes, where
          -- change_base silently no-ops — wait for a post-attach event.
          local ok, gs_cache = pcall(require, "gitsigns.cache")
          if not ok or not gs_cache.cache[bufnr] then
            return
          end
          vim.b[bufnr].gitsigns_main_base_applied = true
          local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
          local base = require("functions.git-main-merge-base")(dir)
          if base then
            vim.api.nvim_buf_call(bufnr, function()
              require("gitsigns").change_base(base)
            end)
          end
        end,
      })

      -- Toggle the hunk base between the merge-base with main (default, see
      -- on_attach) and the index (uncommitted changes only).
      -- NOTE: in merge-base mode, <leader>gr resets hunks to the merge-base
      -- version — it can rewrite committed work in the buffer (undo with u).
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
