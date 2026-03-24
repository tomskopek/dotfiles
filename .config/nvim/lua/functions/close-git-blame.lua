return function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "gitsigns.blame" then
      vim.api.nvim_win_close(win, true)
      return true
    end
  end
  return false
end
