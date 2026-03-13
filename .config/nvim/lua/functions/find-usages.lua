-- Find references, excluding import/export lines
local js_patterns = {
  "^import ", "^const .+ = require", "^let .+ = require", "^var .+ = require",
  "^export ", "^module%.exports",
}
local skip_filenames_by_ft = {
  python = { "/test_[^/]*%.py$" },
}

local skip_patterns_by_ft = {
  python = { "^import ", "^from %S+ import " },
  javascript = js_patterns,
  typescript = js_patterns,
  javascriptreact = js_patterns,
  typescriptreact = js_patterns,
}

-- Definition patterns that use the search word (populated dynamically)
local function get_definition_patterns(word, ft)
  local js_defs = {
    "^const " .. word .. "[%s=:%(]",
    "^let " .. word .. "[%s=:%(]",
    "^var " .. word .. "[%s=:%(]",
    "^function " .. word .. "[%s%(]",
    "^class " .. word .. "[%s{%(]",
  }
  local py_defs = {
    "^def " .. word .. "[%s%(]",
    "^class " .. word .. "[%s%(:]",
    "^" .. word .. "%s*=",
  }
  local defs_by_ft = {
    python = py_defs,
    javascript = js_defs,
    typescript = js_defs,
    javascriptreact = js_defs,
    typescriptreact = js_defs,
  }
  return defs_by_ft[ft] or {}
end

vim.keymap.set("n", "gu", function()
  local ft = vim.bo.filetype
  local word = vim.fn.expand("<cword>")
  local patterns = skip_patterns_by_ft[ft]
  local filename_patterns = skip_filenames_by_ft[ft]
  local def_patterns = get_definition_patterns(word, ft)
  vim.lsp.buf.references(nil, {
    on_list = function(options)
      local filtered = {}
      for _, item in ipairs(options.items) do
        local text = vim.trim(item.text or "")
        local should_skip = false
        if filename_patterns and item.filename then
          for _, pattern in ipairs(filename_patterns) do
            if item.filename:match(pattern) then
              should_skip = true
              break
            end
          end
        end
        if not should_skip and patterns then
          for _, pattern in ipairs(patterns) do
            if text:match(pattern) then
              should_skip = true
              break
            end
          end
        end
        if not should_skip then
          for _, pattern in ipairs(def_patterns) do
            if text:match(pattern) then
              should_skip = true
              break
            end
          end
        end
        if not should_skip then
          table.insert(filtered, item)
        end
      end
      options.items = filtered
      vim.fn.setqflist({}, " ", options)
      if #filtered == 1 then
        vim.cmd("silent cfirst")
      else
        vim.cmd("copen")
      end
    end,
  })
end, { desc = "Find [U]sages" })
