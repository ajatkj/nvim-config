---@type vim.lsp.Config
return {
  init_options = {
    settings = {
      lint = {
        select = { "E", "F" },
      },
      lineLength = 120,
      configurationPreference = "filesystemFirst"
    },
  },
}
