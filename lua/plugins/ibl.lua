local icons = require("icons").misc

return {

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				indent = {
					char = icons.vbar_half,
					smart_indent_cap = false,
				},
				whitespace = {
					remove_blankline_trail = false,
					highlight = { "Function" },
				},
				scope = {
					enabled = true,
					char = icons.vbar_solid,
					show_start = false,
					show_end = false,
				},
				exclude = {
					filetypes = {
						--"checkhealth",
						"git",
						"gitcommit",
						"help",
						"lazy",
						"lspinfo",
						"man",
						"mason",
						"notify",
						"Outline",
						"TelescopePrompt",
						"TelescopeResults",
						"terminal",
						"toggleterm",
						--"Trouble",
					},
				},
			}
		end,
		main = "ibl",
	},
}
