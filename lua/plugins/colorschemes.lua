return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			undercurl = false,
			functionStyle = { italic = true },
			dimInactive = true,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					-- Remove annoying wavy underline from html links
					["@string.special.url"] = { fg = theme.syn.special1, undercurl = false, italic = true },

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				}
			end,
		})
		vim.cmd.colorscheme("kanagawa")
	end,
}
-- return {
-- 	"AlexvZyl/nordic.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("nordic").setup({
-- 			bold_keywords = true,
-- 			italic_comments = true,
-- 			bright_border = true,
-- 			swap_backgrounds = true,
-- 		})
-- 		require("nordic").load()
-- 	end,
-- }
-- return {
-- 	"jesseleite/nvim-noirbuddy",
-- 	dependencies = {
-- 		{ "tjdevries/colorbuddy.nvim" },
-- 	},
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
-- 		preset = "slate",
-- 		-- All of your `setup(opts)` will go here
-- 	},
-- }
-- return {
-- 	"sainnhe/gruvbox-material",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		-- Optionally configure and load the colorscheme
-- 		-- directly inside the plugin declaration.
-- 		vim.g.gruvbox_material_enable_italic = true
-- 		vim.g.gruvbox_material_background = "hard"
-- 		vim.cmd.colorscheme("gruvbox-material")
-- 	end,
-- }
-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	lazy = false,
-- 	name = "kanagawa",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("kanagawa")
-- 	end,
-- }
-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false,
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }
