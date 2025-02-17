return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-buffer',
    },
    event = "InsertEnter",
    config = function()
      local cmp = require('cmp')

      cmp.setup {
        sources = {
          { name = 'nvim_lsp' },
          { name = "buffer", keyword_length = 3 },
        },
        mapping = cmp.mapping.preset.insert {
          -- You can add or customize your key mappings here if needed
        },
      }

      -- Auto-import on selecting a completion item
      cmp.event:on('confirm_done', function()
        vim.lsp.buf.code_action()
      end)
    end,
  }
}
