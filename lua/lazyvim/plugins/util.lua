return {

	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				style_preset = {
					require("bufferline").style_preset.no_italic,
					require("bufferline").style_preset.no_bold,
				},
			},
			highlights = {
				fill = {
					bg = "#1b202a",
				},
			},
		},
	},

	{
		"ray-x/web-tools.nvim",
		opts = {
			keymaps = {
				rename = nil, -- by default use same setup of lspconfig
				-- repeat_rename = ".", -- . to repeat
			},
			hurl = { -- hurl default
				show_headers = false, -- do not show http headers
				floating = false, -- use floating windows (need guihua.lua)
				json5 = false,
				formatters = { -- format the result by filetype
					json = { "jq" },
					html = { "prettier", "--parser", "html" },
				},
			},
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"lervag/vimtex",
		-- opt = true,
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_view_general_viewer = "zathura"
			vim.g.vimtex_compiler_latexmk_engines = {
				_ = "-lualatex",
			}
			vim.g.tex_comment_nospell = 1
			vim.g.vimtex_compiler_progname = "latexrun"
			vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
			-- vim.g.vimtex_view_general_options_latexmk = '--unique'
		end,
		ft = "tex",
	},

	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			return {
				require("colorizer").setup({
					filetypes = { "*" },
					user_default_options = {
						RGB = true, -- #RGB hex codes
						RRGGBB = true, -- #RRGGBB hex codes
						names = false, -- "Name" codes like Blue or blue
						RRGGBBAA = false, -- #RRGGBBAA hex codes
						AARRGGBB = false, -- 0xAARRGGBB hex codes
						rgb_fn = false, -- CSS rgb() and rgba() functions
						hsl_fn = false, -- CSS hsl() and hsla() functions
						css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
						css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
						-- Available modes for `mode`: foreground, background,  virtualtext
						mode = "background", -- Set the display mode.
						-- Available methods are false / true / "normal" / "lsp" / "both"
						-- True is same as normal
						tailwind = false, -- Enable tailwind colors
						-- parsers can contain values used in |user_default_options|
						sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
						virtualtext = "■",
						-- update color values even if buffer is not focused
						-- example use: cmp_menu, cmp_docs
						always_update = false,
					},
					-- all the sub-options of filetypes apply to buftypes
					buftypes = {},
				}),
			}
		end,
	},

	{
		"kevinhwang91/rnvimr",
		-- keys = { { "<leader>r", "" } },
		init = function()
			vim.g.rnvimr_draw_border = 1
			vim.g.rnvimr_enable_bw = 1
			local winwd = vim.fn.winwidth(0)
			local winhg = vim.fn.winheight(0)
			vim.g.rnvimr_layout = {
				relative = "editor",
				width = winwd * 0.900,
				height = winhg * 0.900,
				col = winwd * 0.050,
				row = winhg * 0.050,
				style = "minimal",
			}
			vim.g.rnvimr_ranger_cmd = {
				"ranger",
				"--cmd=set preview_directories true",
				-- "--cmd=set column_ratios 2,5,0",
				-- "--cmd=set preview_files false",
				-- "--cmd=set preview_images truefalse",
				-- "--cmd=set padding_right false",
				-- "--cmd=set collapse_preview true",
			}
		end,
		config = function()
			vim.keymap.set("n", "<leader>r", function()
				vim.api.nvim_command("RnvimrToggle")
			end, { desc = "Ranger" })
		end,
	},

	-- custom edgy
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
    },
		opts = function()
			local opts = {
				exit_when_last = true,
				animate = {
					enabled = false,
				},
				wo = {
					winbar = false,
				},

				bottom = {
					{
						ft = "lazyterm",
						title = "LazyTerm",
						size = { height = 0.25 },
						filter = function(buf)
							return not vim.b[buf].lazyterm_cmd
						end,
					},
					-- "Trouble",
					-- {
					--   ft = "trouble",
					--   filter = function(buf, win)
					--     return vim.api.nvim_win_get_config(win).relative == ""
					--   end,
					-- },
					-- { ft = "qf", title = "QuickFix" },
					-- {
					--   ft = "help",
					--   size = { height = 20 },
					--   -- don't open help files in edgy that we're editing
					--   filter = function(buf)
					--     return vim.bo[buf].buftype == "help"
					--   end,
					-- },
					-- { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
					-- { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
				},
				-- left = {
					-- {
					--   title = "Neo-Tree",
					--   ft = "neo-tree",
					--   filter = function(buf)
					--     return vim.b[buf].neo_tree_source == "filesystem"
					--   end,
					--   pinned = true,
					--   open = function()
					--     vim.api.nvim_input("<esc><space>e")
					--   end,
					--   size = { height = 0.5 },
					-- },
						-- "neo-tree",
				-- },
			}
			return opts
		end,
	},

	-- prevent neo-tree from opening files in edgy windows
	{
		"nvim-neo-tree/neo-tree.nvim",
		optional = true,
		opts = function(_, opts)
			opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
				or { "terminal", "Trouble", "qf", "Outline", "trouble" }
			table.insert(opts.open_files_do_not_replace_types, "edgy")
		end,
	},

	-- -- Fix bufferline offsets when edgy is loaded
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	optional = true,
	-- 	opts = function()
	-- 		local Offset = require("bufferline.offset")
	-- 		if not Offset.edgy then
	-- 			local get = Offset.get
	-- 			Offset.get = function()
	-- 				if package.loaded.edgy then
	-- 					local layout = require("edgy.config").layout
	-- 					local ret = { left = "", left_size = 0, right = "", right_size = 0 }
	-- 					for _, pos in ipairs({ "left", "right" }) do
	-- 						local sb = layout[pos]
	-- 						if sb and #sb.wins > 0 then
	-- 							local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
	-- 							ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
	-- 							ret[pos .. "_size"] = sb.bounds.width
	-- 						end
	-- 					end
	-- 					ret.total_size = ret.left_size + ret.right_size
	-- 					if ret.total_size > 0 then
	-- 						return ret
	-- 					end
	-- 				end
	-- 				return get()
	-- 			end
	-- 			Offset.edgy = true
	-- 		end
	-- 	end,
	-- },

	-- { "jpalardy/vim-slime" },
	-- { "luckasRanarison/nvim-devdocs" }
}
