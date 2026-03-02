-- The built-in ftplugin/python.vim sets shiftwidth=4 (PEP 8 default).
-- If a project has a .editorconfig, we need to re-apply its values here
-- because the built-in ftplugin (4) can sometimes run AFTER editorconfig and overwrites them.
-- Then this is the last thing that is run.
-- Useful debugging commands:
-- :verbose set shiftwidth? — tells you exactly which script last set a value
-- :echo vim.b.editorconfig — confirms what editorconfig parsed
local ec = vim.b.editorconfig or {}  -- get editorconfig
local default_size = 4  -- I like indent of 4 personally, if it is not defined at the project level
local size = tonumber(ec.indent_size) or default_size
vim.opt_local.shiftwidth = size
vim.opt_local.tabstop = size
vim.opt_local.softtabstop = size

vim.opt_local.colorcolumn = "100"
vim.opt_local.foldmethod = "indent"
