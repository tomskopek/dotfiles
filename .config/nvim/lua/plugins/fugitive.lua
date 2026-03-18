local function close_diff()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("^fugitive://") then
      vim.api.nvim_win_close(win, true)
    end
  end
end

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
