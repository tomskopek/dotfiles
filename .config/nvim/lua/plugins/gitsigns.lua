return {
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require("gitsigns").setup({
        on_attach = function (bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          map('n', '<leader>gph', gitsigns.preview_hunk, {
            desc = '[G]it [P]review [H]unk'
          })

          map('n', '<leader>gb', gitsigns.blame,  {
            desc = '[G]it [B]lame'
          })
      end,
    })
  end,
}
}
