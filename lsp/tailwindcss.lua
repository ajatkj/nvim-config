---@type vim.lsp.Config
return {
  -- Keep Tailwind available for supported template files, but never attach it
  -- to PHP files such as Laravel controllers.
  filetypes = {
    "blade",
    "html",
    "liquid",
    "markdown",
    "twig",
    "css",
    "less",
  },
}
