return {
  {
    "tpope/vim-fugitive",
    keys = {
      {
        "<leader>gd",
        function()
          if vim.wo.diff then
            vim.cmd("only")
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
            vim.cmd("only")
          else
            vim.cmd("Gvdiffsplit main")
          end
        end,
        desc = "[G]it [D]iff split vs main (toggle)",
      },
    },
  },
}
