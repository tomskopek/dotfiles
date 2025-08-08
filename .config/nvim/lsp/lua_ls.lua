-- Lua Language Server Configuration
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        globals = { "vim" }, -- Suppress "undefined global vim" warning
        disable = { "missing-fields" }, -- Ignore Lua_LS's noisy `missing-fields` warnings
      },
    },
  },
}
