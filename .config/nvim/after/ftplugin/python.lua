-- Only set these when editorconfig hasn't specified indent_size.
-- Context: if a project has a .editorconfig, there can sometimes be a race condition
--   where these settings load and override the .editorconfig.
--   .editorconfig should always take precedence. ie. if a project
--   specifies spacing of 2, we should always use that!
local ec = vim.b.editorconfig or {}
if not ec.indent_size then
  vim.opt_local.shiftwidth = 4
  vim.opt_local.tabstop = 4
  vim.opt_local.softtabstop = 4
end

vim.opt_local.colorcolumn = "100"
vim.opt_local.foldmethod = "indent"
