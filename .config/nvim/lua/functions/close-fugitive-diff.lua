return function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("^fugitive://") then
      vim.api.nvim_win_close(win, true)
    end
  end
end
