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
        },
      }
    end,
  }
}
