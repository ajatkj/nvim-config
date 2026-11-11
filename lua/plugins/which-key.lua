return {
	"folke/which-key.nvim",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			version = false,
		},
	},
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		preset = "helix",
		win = {
			wo = {
				winblend = 20,
			},
		},
		expand = 3,
		plugins = {
			spelling = {
				suggestions = 5,
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
