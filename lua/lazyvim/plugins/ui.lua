return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
			{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
			-- { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
			-- { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		},
		opts = {
			options = {
        -- stylua: ignore
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				enforce_regular_tabs = true,
				max_name_length = 30,
				max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
				tab_size = 17,
				separator_style = { "" }, -- slant | "slope" | "thick" | "thin" | { 'any', 'any' },
				indicator = {
					-- icon = "",
					style = "none",
				},
				always_show_bufferline = true,
				show_buffer_close_icons = false,
				show_tab_indicators = false,
				show_close_icon = false,
				color_icons = true,
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = require("lazyvim.config").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						-- text = "",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "center",
						separator = "",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd("BufAdd", {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local icons = require("lazyvim.config").icons
			return {
				options = {
					theme = "auto",
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "neo-tree" } },
				},
				sections = {
					lualine_a = {
						{ "mode", icon = "", padding = 1 },
					},
					lualine_b = {
						{ "branch", padding = { left = 2, right = 1 } },
						{ "filetype", colored = false, icon_only = true, padding = { left = 1, right = 0 } },
						{ "filename", path = 4, file_status = true, padding = { left = 1, right = 2 } },
					},
					lualine_c = {
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							padding = { left = 2, right = 0 },
						},
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
					},
					lualine_x = {
						{ "encoding", padding = { left = 0, right = 1 } },
						{ "fileformat", padding = { left = 1, right = 1 } },
						{ "filetype", padding = { left = 1, right = 2 } },
					},
					lualine_y = {
						-- { "progress", padding = 1 },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_z = {
						{ "location", padding = 1 },
					},
				},
				extensions = { "lazy" },
			},
      require("lualine").setup({ options = { theme = "onedark", }, })
		end,
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "LazyFile",
		opts = {
			indent = {
				char = "┆",
				tab_char = "╎",
				smart_indent_cap = false,
			},
			whitespace = {
				remove_blankline_trail = true,
				highlight = {
					"Function",
				},
			},
			scope = {
				enabled = true,
				char = "│",
				show_start = true,
				show_end = false,
			},
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},

	-- Displays a popup with possible key bindings of the command you started typing
	{
		"folke/which-key.nvim",
		opts = function(_, opts)
			if LazyVim.has("noice.nvim") then
				opts.defaults["<leader>sn"] = { name = "+noice" }
			end
		end,
	},

	-- icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
}
