return {
  {
    "tpope/vim-rhubarb",
    opts = {},

    keys = {
      { "<leader>go", "<cmd>GBrowse<CR>", mode = "n", desc = "[G]ithub [O]pen file/selection on github.com" },
      { "<leader>go", ":'<,'>GBrowse<CR>", mode = "v", desc = "[G]ithub [O]pen file/selection on github.com" },
      { "<leader>gc", "<cmd>GBrowse!<CR>", mode = { "n" }, desc = "[G]ithub [C]opy github.com URL for selection" },
      { "<leader>gc", ":'<,'>GBrowse!<CR>", mode = { "v" }, desc = "[G]ithub [C]opy github.com URL for selection" },
    },
  },
}
