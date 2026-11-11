return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "UIEnter" },
	main = "ibl",
	opts = {
		indent = {
			char = { "│", "┊" },
			tab_char = { "│", "┊" },
		},
		-- indent = { char = "┊" },
	},
}
