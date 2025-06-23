return {

	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{
				"<C-/>",
				"<cmd>ToggleTerm name='scratchterm' size=15 direction=horizontal<cr>",
				desc = "Toggleterm h-split",
			},
			{ "<leader>tv", "<cmd>ToggleTerm<cr>", desc = "Toggleterm v-split" },
			{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggleterm float" },
			{
				"<leader>tl",
				function()
					require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
				end,
				"v",
				desc = "Send selection to Terminal",
			},
			{
				"<leader>tv",
				function()
					require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
				end,
				"v",
				desc = "Send visual lines to Terminal",
			},
			{
				"<leader>ts",
				function()
					require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
				end,
				"v",
				desc = "Send visual selection to Terminal",
			},
		},
		opts = {
			highlights = {
				Normal = { link = "Normal" },
				NormalNC = { link = "NormalNC" },
				NormalFloat = { link = "Normal" },
				FloatBorder = { link = "NoText" },
				StatusLine = { link = "StatusLine" },
				StatusLineNC = { link = "StatusLineNC" },
				WinBar = { link = "WinBar" },
				WinBarNC = { link = "WinBarNC" },
			},
			size = 15,
			open_mapping = [[<c-/>]],
			terminal_mappings = true,
			shade_terminals = true,
			direction = "horizontal",
			close_on_exit = true,
		},
	},

	{
		"ray-x/web-tools.nvim",
		keys = {
			{ "<leader>cb", "<cmd>BrowserOpen<cr>", "n", desc = "Browser Preview", remap = true },
		},
		opts = {
			keymaps = {
				rename = nil,
				-- repeat_rename = ".", -- . to repeat
			},
			hurl = {
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
		"NvChad/nvim-colorizer.lua",
		config = function()
			return {
				require("colorizer").setup({
					filetypes = { "*" },
					user_default_options = {
						RGB = true, -- #RGB hex codes
						RRGGBB = true, -- #RRGGBB hex codes
						names = false, -- "Name" codes like Blue or blue
						RRGGBBAA = true, -- #RRGGBBAA hex codes
						AARRGGBB = true, -- 0xAARRGGBB hex codes
						rgb_fn = false, -- CSS rgb() and rgba() functions
						hsl_fn = false, -- CSS hsl() and hsla() functions
						css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
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
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "0.3.*",
		build = function()
			require("typst-preview").update()
		end,
		keys = {
			{
				"<leader>ct",
				ft = "typst",
				"<cmd>TypstPreview<cr>",
				desc = "Typst Preview",
			},
		},
	},

  {
    "phelipetls/vim-hugo",
    --lazy = false,
    --opts = {},
    --init = function()
    --  return {
    --    require("vim-hugo").setup()
    --  }
    --end
  },
}
