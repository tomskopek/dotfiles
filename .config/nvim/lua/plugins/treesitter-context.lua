-- Shows the current function/class context pinned at the top of the window
-- when its definition is scrolled out of view.

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 3, -- Limit how many context lines can stack up (0 = unlimited)
    },
  },
}

-- Useful commands
-- ---------------
-- :TSContext toggle/enable/disable
