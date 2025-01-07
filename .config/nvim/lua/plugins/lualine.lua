  -- Statusline
return {
    { "nvim-lualine/lualine.nvim", config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",  -- Use the Gruvbox theme
          icons_enabled = true,  -- Enable icons
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "filename", path = 1 } },  -- Show relative file path
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },
}
