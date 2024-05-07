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
					bg = "#1e222a",
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
		-- cmd = { "RnvimrToggle" },
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
	},

	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		opts = {
			highlights = {
				-- Normal = { link = "Normal" },
				Normal = { link = "CursorColumn" },
				NormalNC = { link = "NormalNC" },
				NormalFloat = { link = "Normal" },
				FloatBorder = { link = "FloatBorder" },
				StatusLine = { link = "StatusLine" },
				StatusLineNC = { link = "StatusLineNC" },
				WinBar = { link = "WinBar" },
				WinBarNC = { link = "WinBarNC" },
			},
			size = 65,
			open_mapping = [[<c-/>]],
			terminal_mappings = true,
			shade_terminals = true,
			-- shading_factor = 0,
			direction = "vertical",
			close_on_exit = true,
			-- float_opts = {
			-- border = "single",
			-- highlights = { border = "Normal", background = "Normal" },
			-- },
		},
	},

	-- clisp
	-- {
	-- 	"neovim/nvim-lspconfig",
	--    config = function()
	-- 		local lspconfig = require("lspconfig")
	--
	-- 		-- Check if the config is already defined (useful when reloading this file)
	-- 		if not lspconfig.configs.cl_lsp then
	-- 			lspconfig.configs.cl_lsp = {
	-- 				default_config = {
	-- 					cmd = { vim.env.HOME .. "~/.roswell/bin/cl-lsp" },
	-- 					filetypes = { "lisp" },
	-- 					root_dir = lspconfig.util.find_git_ancestor,
	-- 					settings = {},
	-- 				},
	-- 			}
	-- 		end
	-- 	end,
	-- },

	{
		"monkoose/nvlime",
		dependencies = {
			"monkoose/parsley",
			"adolenc/cl-neovim",
			"gpanders/nvim-parinfer",
			{
				"nvim-treesitter/nvim-treesitter",
				opts = function(_, opts)
					if type(opts.ensure_installed) == "table" then
						vim.list_extend(opts.ensure_installed, { "commonlisp" })
					end
				end,
			},
		},
		cmp_enabled = function()
			vim.g.nvlime_config.cmp.enabled = true
		end,
		config = function()
			require("cmp").setup.filetype({ "lisp" }, {
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "nvlime" },
				},
			})
		end,
	},

	-- prolog
	{
		"adimit/prolog.vim",
	},

	-- { "jpalardy/vim-slime" },
	-- { "luckasRanarison/nvim-devdocs" }
}
