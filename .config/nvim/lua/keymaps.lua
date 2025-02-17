-- Editing vim
vim.keymap.set("n", "<leader>ev", ":edit ~/.config/nvim/lua/settings.lua<CR>", { silent = true, desc = "Source settings.lua" })
vim.keymap.set("n", "<leader>sv", ":source ~/.config/nvim/lua/settings.lua<CR>", { silent = true, desc = "Source settings.lua" })

vim.keymap.set("n", "<Leader>cw", "m`:%s/\\s\\+$//e<CR>``", { silent = true, desc = "Clear trailing whitespaces" })

vim.keymap.set("n", "<Leader>yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { silent = true, desc = "Yank full file path to clipboard" })
