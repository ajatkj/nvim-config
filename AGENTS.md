# Repository Guidelines

## Project Structure & Module Organization
This repository is a Neovim configuration rooted at `init.lua`.
- `init.lua`: bootstraps `lazy.nvim`, loads options, plugins, and LSP setup.
- `lua/vim-options.lua`: editor options, keymaps, and autocmds.
- `lua/plugins/`: plugin specs and plugin-specific config (including `lua/plugins/lsp/`).
- `lsp/`: per-server LSP settings (for example `lua_ls.lua`, `ruff.lua`, `jsonls.lua`).
- `ftplugin/`: filetype-specific overrides.
- `after_1/queries/`: Treesitter query customizations.
- `lazy-lock.json`: pinned plugin versions.

## Build, Test, and Development Commands
There is no traditional build step; validate by starting Neovim and running health checks.
- `nvim`: launch with this config.
- `nvim --headless "+Lazy! sync" +qa`: install/update plugins and lock to configured specs.
- `nvim --headless "+checkhealth" +qa`: run runtime/provider/plugin diagnostics.
- `nvim --headless "+Mason" +qa` (interactive in normal usage): verify external LSP/tool installers.

## Coding Style & Naming Conventions
- Language: Lua.
- Indentation: 2 spaces; keep line wrapping readable and avoid dense one-liners.
- Modules/files: use snake_case filenames (example: `vim-options.lua`, `todo-comments.lua`).
- Prefer small, focused plugin modules: one plugin (or tightly related group) per file in `lua/plugins/`.
- Keep keymaps/options centralized in `lua/vim-options.lua` unless filetype-specific.

Formatting and linting are primarily handled in-editor:
- Formatting via `conform.nvim` (Stylua for Lua, Prettierd/Ruff/etc. by filetype).
- Linting via `nvim-lint` (`eslint_d`, `shellcheck`, `hadolint`, etc.).

## Testing Guidelines
Automated unit tests are not present in this config repo. Use regression checks instead:
- Start Neovim without startup errors.
- Open representative filetypes (Lua, TS/JS, Python, Shell) and confirm LSP attach, format-on-save, and lint diagnostics.
- Run `:checkhealth` after significant changes.

## Commit & Pull Request Guidelines
Git history is not available in this directory (`.git` is absent), so commit conventions cannot be inferred locally.
Recommended baseline:
- Commit messages in imperative form, concise subject (example: `fix(lsp): disable noisy diagnostics`).
- PRs should include: purpose, impacted modules/paths, manual validation steps, and screenshots/GIFs for visible UI changes.
