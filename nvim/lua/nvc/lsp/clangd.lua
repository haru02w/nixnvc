require('lspconfig').clangd.setup {
  cmd = { 'clangd', '--background-index', '--clang-tidy' },
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { '-std=c++20' },
    },
  },
}
