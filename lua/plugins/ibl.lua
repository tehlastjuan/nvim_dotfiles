return {

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				indent = {
					char = "┆",
					tab_char = "╎",
					smart_indent_cap = false,
				},
				whitespace = {
					remove_blankline_trail = true,
					highlight = { "Function" },
				},
				scope = {
					enabled = true,
					char = "│",
					show_start = true,
					show_end = false,
				},
				exclude = {
					filetypes = {
						"alpha",
						"checkhealth",
						"dashboard",
						"git",
						"gitcommit",
						"help",
						"lazy",
						"lazyterm",
						"lspinfo",
						"man",
						"mason",
						"neo-tree",
						"notify",
						"Outline",
						"TelescopePrompt",
						"TelescopeResults",
						"terminal",
						"toggleterm",
						"Trouble",
					},
				},
			}
		end,
		main = "ibl",
	},
}
