-- Python Language Server Configuration (basedpyright)
return {
  settings = {
    basedpyright = {
      typeCheckingMode = 'off', -- basic type checking (off/basic/strict)
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
