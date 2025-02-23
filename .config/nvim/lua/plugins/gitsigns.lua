return {
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require("gitsigns").setup()
    end,
  }
}
