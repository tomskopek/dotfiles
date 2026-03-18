local close_diff = require("functions.close-fugitive-diff")

return {
  {
    "tpope/vim-fugitive",
    keys = {
      {
        "<leader>gd",
        function()
          if vim.wo.diff then
            close_diff()
          else
            vim.cmd("Gvdiffsplit")
          end
        end,
        desc = "[G]it [D]iff split (toggle)",
      },
      {
        "<leader>gD",
        function()
          if vim.wo.diff then
            close_diff()
          else
            vim.cmd("Gvdiffsplit main")
          end
        end,
        desc = "[G]it [D]iff split vs main (toggle)",
      },
    },
  },
}
