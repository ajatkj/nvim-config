# Ankit's Neovim configuration

A focused Neovim configuration for modern development, with lazy-loaded plugins, LSP support, completion, formatting, linting, Git integration, and opinionated editor defaults.

## Highlights

- `lazy.nvim` plugin management with a committed lockfile
- LSP configuration for Lua, Python, TypeScript, web technologies, JSON, YAML, TOML, Prisma, PHP, and Java
- Blink completion, Treesitter, FZF-Lua, Trouble, Outline, and Which-Key
- Mason-managed formatters and linters through Conform and nvim-lint
- Git signs, Fugitive, LazyGit, Markdown rendering, and a Kanagawa-based UI

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
