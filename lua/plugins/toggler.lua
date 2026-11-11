return {
	"nguyenvukhang/nvim-toggler",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local toggler = require("nvim-toggler")
		toggler.setup({
			remove_default_keybinds = true,
			inverses = {
				[">="] = "<=",
				[">"] = "<",
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>i", require("nvim-toggler").toggle, { desc = "Toggle word under cursor" })
	end,
}
