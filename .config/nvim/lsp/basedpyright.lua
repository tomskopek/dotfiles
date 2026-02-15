-- Python Language Server Configuration (basedpyright)
return {
  settings = {
    basedpyright = {
      typeCheckingMode = 'off', -- basic type checking (off/basic/strict)
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          reportMissingImports = "error", -- Flag imports of packages that cannot be resolved
        },
      },
    },
  },
}
