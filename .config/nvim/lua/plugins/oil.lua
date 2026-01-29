return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true
      },
    },
    keys = {
      { "<c-f>", "<cmd>Oil<cr>", desc = "Toggle Oil" },
    },
    -- Optional dependencies
    -- dependencies = { { "nvim-mini/mini.icons", opts = {} } }, -- use if you prefer mini icons
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}
