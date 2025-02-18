-- Editing vim
vim.keymap.set("n", "<leader>ev", ":edit ~/.config/nvim/lua/settings.lua<CR>", { silent = true, desc = "Source settings.lua" })
vim.keymap.set("n", "<leader>sv", ":source ~/.config/nvim/lua/settings.lua<CR>", { silent = true, desc = "Source settings.lua" })

vim.keymap.set("n", "<Leader>cw", "m`:%s/\\s\\+$//e<CR>``", { silent = true, desc = "Clear trailing whitespaces" })

vim.keymap.set("n", "<Leader>yf", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { silent = true, desc = "Yank full file path to clipboard" })

vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true, desc = "Go to Definition" })
vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true, desc = "Find Usages" })

-- Hint: To discover what other actions are possible for the word under cursor:
-- :lua vim.lsp.buf.code_action({ filter = function(a) print(vim.inspect(a)) return false end })

vim.keymap.set("n", "<leader>i", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.kind == "quickfix" and action.command and action.command.arguments
        and action.command.arguments[1] and action.command.arguments[1].fixName == "import"
    end,
    apply = true,
  })
end, { desc = "Auto-import missing symbols", silent = true })
