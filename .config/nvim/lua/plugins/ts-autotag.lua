-- Use treesitter to autoclose and autorename html tags
return {
  "windwp/nvim-ts-autotag",
  enabled = true,
  event = "VimEnter",
  opts = {
    opts = {
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = true, -- Auto close on trailing </
    },
  },
}
