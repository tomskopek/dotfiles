-- Shows the current function/class context pinned at the top of the window
-- when its definition is scrolled out of view.

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 5, -- Limit how many context lines can stack up (0 = unlimited)
      -- When over max_lines, drop the innermost contexts (if/for blocks) first,
      -- so the enclosing class/function names always stay visible.
      -- (Default is 'outer', which drops class/function first — the opposite of useful.)
      trim_scope = "inner",
      separator = "─", -- Line drawn under the context, highlighted with TreesitterContextSeparator
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)

      -- Make the context visually distinct from the buffer.
      -- Links (rather than hardcoded colors) so this adapts to whatever colorscheme is active.
      local function set_highlights()
        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })
        vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { link = "CursorLineNr" })
        vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { link = "Comment" })
      end
      set_highlights()

      -- :colorscheme clears custom highlights, so reapply them after it runs
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("treesitter-context-highlights", { clear = true }),
        callback = set_highlights,
      })

      -- Jump to the enclosing context line (class motions live on ]k/[k to keep this free)
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true, desc = "Jump to enclosing context" })
    end,
  },
}

-- Useful commands
-- ---------------
-- :TSContext toggle/enable/disable
