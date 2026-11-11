# Neovim configuration

A focused Neovim configuration for modern development, with lazy-loaded plugins, LSP support, completion, formatting, linting, Git integration, and opinionated editor defaults.

## Highlights

- `lazy.nvim` plugin management with a committed lockfile
- LSP configuration for Lua, Python, TypeScript, web technologies, JSON, YAML, TOML, Prisma, PHP, and Java
- Blink completion, Treesitter, FZF-Lua, Trouble, Outline, and Which-Key
- Mason-managed formatters and linters through Conform and nvim-lint
- Git signs, Fugitive, LazyGit, Markdown rendering, and a Kanagawa-based UI

## Plugins

The configuration uses the following directly configured plugins. Supporting dependency plugins are omitted from this catalog.

### Completion and snippets

| Plugin | Purpose |
| --- | --- |
| [blink.cmp](https://github.com/Saghen/blink.cmp) | Fast completion with LSP, path, buffer, and snippet sources |

### LSP and code intelligence

| Plugin | Purpose |
| --- | --- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP server configuration and integration |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Installer and manager for LSP servers and development tools |
| [better-ts-errors.nvim](https://github.com/OlegGulevskyy/better-ts-errors.nvim) | Displays clearer TypeScript errors |
| [outline.nvim](https://github.com/hedyhli/outline.nvim) | Symbol and document outline navigation |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Structured diagnostics and quickfix views |
| [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim) | JSON and YAML schema support |

Mason-managed language servers, formatters, and linters are external tools and are documented separately from this plugin list.

### Search, pickers, and navigation

| Plugin | Purpose |
| --- | --- |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finding for files, buffers, symbols, diagnostics, and more |
| [fff](https://github.com/dmtrKovalenko/fff) | Fast file picker |
| [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim) | Context-aware winbar and symbol navigation |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File-system browser and editable directory buffers |
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | Search and replace across files |
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua) | Persistent clipboard and macro history picker |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Searches and navigates TODO, FIXME, and related comments |

### Formatting and linting

| Plugin | Purpose |
| --- | --- |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format-on-save and formatter orchestration |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Asynchronous linting and diagnostics |

### Syntax, editing, and code structure

| Plugin | Purpose |
| --- | --- |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax parsing, highlighting, and indentation |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Comment and uncomment motions |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Automatically closes paired characters |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Modern code folding and fold previews |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [vim-illuminate](https://github.com/RRethy/vim-illuminate) | Highlights other uses of the symbol under the cursor |
| [eyeliner.nvim](https://github.com/jinh0/eyeliner.nvim) | Highlights jump targets for `f`, `F`, `t`, and `T` motions |
| [nvim-toggler](https://github.com/nguyenvukhang/nvim-toggler) | Toggles configured word and operator pairs |

### Git

| Plugin | Purpose |
| --- | --- |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs, hunk actions, and blame information |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands and workflows inside Neovim |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Opens LazyGit from Neovim |

### UI, theme, and statusline

| Plugin | Purpose |
| --- | --- |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Color scheme and editor palette |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline with Git, LSP, file, and environment information |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Startup dashboard |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Displays available keybindings and command groups |

### Markdown, data, and utilities

| Plugin | Purpose |
| --- | --- |
| [markview.nvim](https://github.com/OXY2DEV/markview.nvim) | Renders Markdown in the editor |
| [csvview.nvim](https://github.com/hat0uma/csvview.nvim) | Interactive CSV and tabular data viewer |
| [oklch-color-picker.nvim](https://github.com/eero-lehtinen/oklch-color-picker.nvim) | Picks and previews OKLCH colors |

## Requirements

- Neovim 0.12 or newer
- Git 2.19 or newer
- A Nerd Font for icons
- A working C compiler for native plugin builds where required
- Optional language runtimes and tools for the languages you use

The configuration installs `lazy.nvim` automatically on first launch. Mason installs the configured formatters, linters, and Python language servers. Other language servers may require a system runtime or project-specific setup.

Java support expects JDK 17 or newer, `JAVA_HOME` when the JDK is not in the default macOS location, and the Mason `jdtls` package. Java is skipped gracefully if the JDTLS plugin is unavailable.

## Installation

Back up an existing configuration, then clone this repository to Neovim's config directory:

```sh
mv ~/.config/nvim ~/.config/nvim.backup
git clone https://github.com/<your-user>/<your-repo>.git ~/.config/nvim
nvim
```

For a quick local checkout without replacing an existing configuration:

```sh
git clone https://github.com/<your-user>/<your-repo>.git ~/src/nvim-config
XDG_CONFIG_HOME="$HOME/src" NVIM_APPNAME=nvim-config nvim
```

On first launch, allow Lazy and Mason to install their managed dependencies. The lockfile is committed so subsequent installs use known plugin revisions.

## Useful checks

```sh
nvim --headless "+checkhealth" +qa
nvim --headless "+Lazy! sync" +qa
```

Inside Neovim, use `:Lazy`, `:Mason`, `:LspInfo`, and `:ConformInfo` to inspect plugin, tool, language-server, and formatter state.

## Customization

- General options and editor behavior live in `lua/vim-options.lua`.
- Keymaps live in `lua/keymaps.lua`.
- Plugin specifications live under `lua/plugins/`.
- Language-server settings live under `lsp/`.
- Filetype-specific behavior lives under `ftplugin/` and `after/ftplugin/`.

Fork the repository and edit those focused modules. Run the headless checks above after changing plugin or LSP configuration.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request. This configuration is personal and opinionated, so proposed changes should explain the user-facing benefit and include validation steps.

## License

This configuration is released under the [MIT License](LICENSE).
