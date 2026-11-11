local cap = vim.lsp.protocol.make_client_capabilities()
local blink_cmp = require("blink.cmp")
local capabilities = blink_cmp.get_lsp_capabilities(cap)
local keymap = vim.keymap -- for conciseness
-- import fzflua (using fzflua instead of telescope)
local fzf_lua = require("fzf-lua")
--
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_config", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }
    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gR", fzf_lua.lsp_references, opts) -- show definition, references

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", fzf_lua.lsp_definitions, opts) -- show lsp definitions

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", fzf_lua.lsp_implementations, opts) -- show lsp implementations

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", fzf_lua.lsp_typedefs, opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", fzf_lua.lsp_code_actions, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", fzf_lua.lsp_document_diagnostics, opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":lsp restart<CR>", opts) -- mapping to restart lsp if necessary
  end,
})
--
-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = "", Warn = "", Hint = "󰠠", Info = "" }
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs["Error"],
      [vim.diagnostic.severity.WARN] = signs["Warn"],
      [vim.diagnostic.severity.HINT] = signs["Hint"],
      [vim.diagnostic.severity.INFO] = signs["Info"],
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
    -- linehl = {
    -- 	[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
    -- 	[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    -- 	[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    -- 	[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    -- },
  },
})

vim.lsp.config('*', {
  capabilities = capabilities
})
vim.lsp.config("tailwindcss", {
  -- Override nvim-lspconfig's default list, which includes PHP.
  filetypes = {
    "blade",
    "html",
    "liquid",
    "markdown",
    "twig",
    "css",
    "less",
    "typescript", "typescriptreact", "javascript", "javascriptreact"
  },
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("bashls")
vim.lsp.enable("cssls")
vim.lsp.enable("dockerls")
vim.lsp.enable("yamlls")
vim.lsp.enable("jsonls")
vim.lsp.enable("taplo")
vim.lsp.enable("intelephense")
vim.lsp.enable("ty")
vim.lsp.enable("prismals")
vim.lsp.enable('laravel_ls')
