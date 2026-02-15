-- Find references, excluding import lines
local import_patterns_by_ft = {
  python = { "^import ", "^from %S+ import " },
  javascript = { "^import ", "^const .+ = require", "^let .+ = require", "^var .+ = require" },
  typescript = { "^import ", "^const .+ = require", "^let .+ = require", "^var .+ = require" },
  javascriptreact = { "^import ", "^const .+ = require", "^let .+ = require", "^var .+ = require" },
  typescriptreact = { "^import ", "^const .+ = require", "^let .+ = require", "^var .+ = require" },
}

vim.keymap.set("n", "gri", function()
  local ft = vim.bo.filetype
  local patterns = import_patterns_by_ft[ft]
  vim.lsp.buf.references(nil, {
    on_list = function(options)
      local filtered = {}
      for _, item in ipairs(options.items) do
        local text = vim.trim(item.text or "")
        local is_import = false
        if patterns then
          for _, pattern in ipairs(patterns) do
            if text:match(pattern) then
              is_import = true
              break
            end
          end
        end
        if not is_import then
          table.insert(filtered, item)
        end
      end
      options.items = filtered
      vim.fn.setqflist({}, " ", options)
      if #filtered == 1 then
        vim.cmd("cfirst")
      else
        vim.cmd("copen")
      end
    end,
  })
end, { desc = "Find [R]eferences (excluding imports)" })
