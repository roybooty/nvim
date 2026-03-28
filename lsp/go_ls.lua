-- lua/lsp/go.lua
return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true, -- Strict formatting
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
}
