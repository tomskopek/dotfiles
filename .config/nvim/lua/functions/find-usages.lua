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

-- Check if a line is inside a multiline `from ... import (` block
local function is_in_multiline_import(file_lines_cache, filename, lnum)
  if not file_lines_cache[filename] then
    file_lines_cache[filename] = vim.fn.readfile(filename)
  end
  local lines = file_lines_cache[filename]
  local multiline_import_start = "^from %S+ import %($"
  local import_block_content = "^[%w_,%(%)%s]+$"
  for i = lnum, 1, -1 do
    local line = vim.trim(lines[i] or "")
    if line:match(multiline_import_start) then
      return true
    end
    -- Stop scanning if we hit a line that closes a paren or isn't plausibly part of an import block
    if line == ")" or (line ~= "" and not line:match(import_block_content)) then
      return false
    end
  end
  return false
end

-- Additional skip functions by filetype.
-- Each factory receives (word, file_lines_cache) and returns a function (item, text) -> bool.
local skip_fn_factories_by_ft = {
  python = {
    function(word, file_lines_cache)
      local trailing_comma_pattern = "^" .. word .. ",$"
      return function(item, text)
        local is_potentially_part_of_import_block = text:match(trailing_comma_pattern)
        if is_potentially_part_of_import_block and item.filename and item.lnum then
          return is_in_multiline_import(file_lines_cache, item.filename, item.lnum)
        end
        return false
      end
    end,
  },
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
  local file_lines_cache = {}
  local skip_fns = {}
  for _, factory in ipairs(skip_fn_factories_by_ft[ft] or {}) do
    table.insert(skip_fns, factory(word, file_lines_cache))
  end
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
          for _, fn in ipairs(skip_fns) do
            if fn(item, text) then
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
