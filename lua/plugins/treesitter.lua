return {

	-- Syntax highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				opts = {
					-- Avoid the sticky context from growing a lot.
					max_lines = 3,
					-- Match the context lines to the source code.
					multiline_threshold = 1,
					-- Disable it when the window is too small.
					min_window_height = 20,
				},
				keys = {
					{
						"[c",
						function()
							-- Jump to previous change when in diffview.
							if vim.wo.diff then
								return "[c"
							else
								vim.schedule(function()
									require("treesitter-context").go_to_context()
								end)
								return "<Ignore>"
							end
						end,
						desc = "Jump to upper context",
						expr = true,
					},
				},
			},
		},
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		--event = { "BufReadPre", "BufNewFile" },
		--lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		opts_extend = { "ensure_installed" },
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			highlight = { enable = true },
			indent = { enable = false },
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
        "cmake",
				"css",
				"diff",
				"dockerfile",
				"go",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"jsonc",
				"lua",
				"luap",
				"luadoc",
				"markdown",
				"markdown_inline",
				"php",
				"printf",
				"python",
				"query",
				"regex",
				"rust",
				"scss",
				"sql",
				"toml",
				"tsx",
				"tsx",
				"typescript",
				"typst",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			local toggle_inc_selection_group =
				vim.api.nvim_create_augroup("tehlastjuan/toggle_inc_selection", { clear = true })
			vim.api.nvim_create_autocmd("CmdwinEnter", {
				desc = "Disable incremental selection when entering the cmdline window",
				group = toggle_inc_selection_group,
				command = "TSBufDisable incremental_selection",
			})
			vim.api.nvim_create_autocmd("CmdwinLeave", {
				desc = "Enable incremental selection when leaving the cmdline window",
				group = toggle_inc_selection_group,
				command = "TSBufEnable incremental_selection",
			})

			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	--{
	--	"folke/which-key.nvim",
	--	opts = {
	--		spec = {
	--			{ "<BS>", desc = "Decrement Selection", mode = "x" },
	--			{ "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
	--		},
	--	},
	--},

	-- Automatically add closing tags for HTML and JSX
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		opts = {},
	},

	-- Comment strings
	{
		"folke/ts-comments.nvim",
		event = "BufReadPre",
		opts = {},
	},
}
