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
				repeat_rename = ".", -- . to repeat
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
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
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
				-- { ft = "qf", title = "QuickFix" },
				-- {
				-- 	ft = "help",
				-- 	size = { height = 20 },
				-- 	-- only show help buffers
				-- 	filter = function(buf)
				-- 		return vim.bo[buf].buftype == "help"
				-- 	end,
				-- },
			},
			left = {
			-- 	-- Neo-tree filesystem always takes half the screen height
			-- 	{
			-- 		title = "Neo-Tree",
			-- 		ft = "neo-tree",
			-- 		filter = function(buf)
			-- 			return vim.b[buf].neo_tree_source == "filesystem"
			-- 		end,
			-- 		size = { height = 0.5 },
			-- 	},
			-- 	{
			-- 		title = "Neo-Tree Git",
			-- 		ft = "neo-tree",
			-- 		filter = function(buf)
			-- 			return vim.b[buf].neo_tree_source == "git_status"
			-- 		end,
			-- 		pinned = true,
			-- 		open = "Neotree position=right git_status",
			-- 	},
			-- 	{
			-- 		title = "Neo-Tree Buffers",
			-- 		ft = "neo-tree",
			-- 		filter = function(buf)
			-- 			return vim.b[buf].neo_tree_source == "buffers"
			-- 		end,
			-- 		pinned = true,
			-- 		open = "Neotree position=top buffers",
			-- 	},
			-- 	{
			-- 		ft = "Outline",
			-- 		pinned = true,
			-- 		open = "SymbolsOutlineOpen",
			-- 	},
			-- 	-- any other neo-tree windows
				"neo-tree",
			},
			-- keys = {
			-- 	-- increase width
			-- 	["<c-Right>"] = function(win)
			-- 		win:resize("width", 2)
			-- 	end,
			-- 	-- decrease width
			-- 	["<c-Left>"] = function(win)
			-- 		win:resize("width", -2)
			-- 	end,
			-- 	-- increase height
			-- 	["<c-Up>"] = function(win)
			-- 		win:resize("height", 2)
			-- 	end,
			-- 	-- decrease height
			-- 	["<c-Down>"] = function(win)
			-- 		win:resize("height", -2)
			-- 	end,
			-- },
		},
	},

	-- {
	-- 	"jpalardy/vim-slime",
	-- 	lazy = false,
	-- 	init = function()
	-- 		vim.g.slime_no_mappings = 1
	-- 		vim.g.slime_cell_delimiter = "# %%"
	-- 		vim.api.nvim_set_keymap(
	-- 			"n",
	-- 			"<Leader>a",
	-- 			':execute "normal \\<Plug>SlimeLineSend"<CR>j',
	-- 			{ noremap = true }
	-- 		)
	-- 		vim.api.nvim_set_keymap("v", "<Leader>s", "<Plug>SlimeRegionSend", { noremap = true })
	-- 		vim.api.nvim_set_keymap(
	-- 			"n",
	-- 			"<Leader>s",
	-- 			':execute "normal \\<Plug>SlimeSendCell"<CR>/' .. vim.g.slime_cell_delimiter .. "<CR>:nohlsearch<CR>",
	-- 			{ noremap = true }
	-- 		)
	-- 	end,
	-- },

	{
		"jpalardy/vim-slime",
		init = function()
			-- these two should be set before the plugin loads
			vim.g.slime_target = "neovim"
			vim.g.slime_no_mappings = true
		end,
		config = function()
			vim.g.slime_input_pid = false
			vim.g.slime_suggest_default = true
			vim.g.slime_menu_config = false
			vim.g.slime_neovim_ignore_unlisted = false
			-- options not set here are g:slime_neovim_menu_order, g:slime_neovim_menu_delimiter, and g:slime_get_jobid
			-- see the documentation above to learn about those options

			-- called MotionSend but works with textobjects as well
			vim.keymap.set("n", "gz", "<Plug>SlimeMotionSend", { remap = true, silent = false })
			vim.keymap.set("n", "gzz", "<Plug>SlimeLineSend", { remap = true, silent = false })
			vim.keymap.set("x", "gz", "<Plug>SlimeRegionSend", { remap = true, silent = false })
			vim.keymap.set("n", "gzc", "<Plug>SlimeConfig", { remap = true, silent = false })
		end,
	},

	-- {
	-- 	"luckasRanarison/nvim-devdocs",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	lazy = false,
	-- 	enable = true,
	-- 	opts = {
	-- 		dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
	-- 		telescope = {}, -- passed to the telescope picker
	-- 		filetypes = {},
	-- 		float_win = { -- passed to nvim_open_win(), see :h api-floatwin
	-- 			relative = "editor",
	-- 			height = 500,
	-- 			width = 800,
	-- 			border = "rounded",
	-- 		},
	-- 		wrap = true, -- text wrap, only applies to floating window
	-- 		previewer_cmd = "glow", -- for example: "glow"
	-- 		cmd_args = { "-w", "80", "-s", "dark", "-p" },
	-- 		cmd_ignore = {}, -- ignore cmd rendering for the listed docs
	-- 		picker_cmd = true, -- use cmd previewer in picker preview
	-- 		picker_cmd_args = { "-w", "80", "-s", "dark", "-p" },
	-- 		mappings = { open_in_browser = "" },
	-- 		ensure_installed = {
	-- 			"c",
	-- 			-- "node",
	-- 			-- "javascript",
	-- 			-- "typescript",
	-- 			-- "npm",
	-- 			-- "sass",
	-- 			-- "css",
	-- 			-- "html",
	-- 			-- "lua-5.4",
	-- 			-- "cpp",
	-- 			-- "go",
	-- 			-- "python-3.12",
	-- 			-- "jsdoc",
	-- 			"git",
	-- 		}, -- get automatically installed
	-- 		after_open = function(bufnr) end, -- callback that runs after the Devdocs window is opened. Devdocs buffer ID will be passed in
	-- 	},
	-- },

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

	-- {
	-- 	"jakemason/ouroboros",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		-- these are the defaults, customize as desired
	-- 		require("ouroboros").setup({
	-- 			extension_preferences_table = {
	-- 				c = { h = 2, hpp = 1 },
	-- 				h = { c = 2, cpp = 1 },
	-- 				cpp = { hpp = 2, h = 1 },
	-- 				hpp = { cpp = 1, c = 2 },
	-- 			},
	-- 			-- if this is true and the matching file is already open in a pane, we'll
	-- 			-- switch to that pane instead of opening it in the current buffer
	-- 			switch_to_open_pane_if_possible = false,
	-- 		})
	-- 	end,
	-- },

	-- {
	-- 	"goolord/alpha-nvim",
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.dashboard").config)
	-- 		local dashboard = require("alpha.themes.dashboard")
	-- 		dashboard.section.header.val = {
	-- 			[[=================     ===============     ===============   ========  ========]],
	-- 			[[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
	-- 			[[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
	-- 			[[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
	-- 			[[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
	-- 			[[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
	-- 			[[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
	-- 			[[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
	-- 			[[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
	-- 			[[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
	-- 			[[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
	-- 			[[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
	-- 			[[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
	-- 			[[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
	-- 			[[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
	-- 			[[||.=='    _-'                                                     `' |  /==.||]],
	-- 			[[=='    _-'                        N E O V I M                         \/   `==]],
	-- 			[[\   _-'                                                                `-_   /]],
	-- 			[[ `''                                                                      ``' ]],
	-- 		}
	--
	-- 		dashboard.section.buttons.val = {
	-- 			dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
	-- 			dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
	-- 			dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
	-- 			dashboard.button("e", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
	-- 			dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
	-- 		}
	-- 	end,
	-- },

	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-emoji",
	-- 		"L3MON4D3/LuaSnip",
	-- 	},
	-- 	---@param opts cmp.ConfigSchema
	-- 	opts = function(_, opts)
	-- 		local has_words_before = function()
	-- 			unpack = unpack or table.unpack
	-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 			return col ~= 0
	-- 				and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- 		end
	--
	-- 		local luasnip = require("luasnip")
	-- 		local cmp = require("cmp")
	--
	-- 		opts.mapping = vim.tbl_extend("force", opts.mapping, {
	-- 			["<Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					-- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
	-- 					cmp.select_next_item()
	-- 				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
	-- 				-- this way you will only jump inside the snippet region
	-- 				elseif luasnip.expand_or_jumpable() then
	-- 					luasnip.expand_or_jump()
	-- 				elseif has_words_before() then
	-- 					cmp.complete()
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					cmp.select_prev_item()
	-- 				elseif luasnip.jumpable(-1) then
	-- 					luasnip.jump(-1)
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 		})
	-- 	end,
	-- },

	-- {
	--   "hrsh7th/nvim-cmp",
	--   opts = function ()
	--     return {
	--       enabled = function()
	--         -- disable completion in comments
	--         local context = require 'cmp.config.context'
	--         -- keep command mode completion enabled when cursor is in a comment
	--         if vim.api.nvim_get_mode().mode == 'c' then
	--           return true
	--         else
	--           return not context.in_treesitter_capture("comment")
	--             and not context.in_syntax_group("Comment")
	--         end
	--       end
	--     }
	--   end
	-- },

	-- {
	--   "nvim-neotest/neotest",
	--   dependencies = {
	--     { "nvim-lua/plenary.nvim" },
	--     { "nvim-treesitter/nvim-treesitter" },
	--     { "antoinemadec/FixCursorHold.nvim" },
	--     { "folke/neodev.nvim" },
	--     -- adapters
	--     { "nvim-neotest/neotest-vim-test" },
	--     { "nvim-neotest/neotest-python" },
	--     { "rouge8/neotest-rust" },
	--     { "nvim-neotest/neotest-go", commit = "05535cb2cfe3ce5c960f65784896d40109572f89" }, -- https://github.com/nvim-neotest/neotest-go/issues/57
	--     { "adrigzr/neotest-mocha" },
	--     { "vim-test/vim-test" },
	--   },
	--   config = function()
	--     -- local neotest_ns = vim.api.nvim_create_namespace("neotest")
	--     -- vim.diagnostic.config({
	--     --   virtual_text = {
	--     --     format = function(diagnostic)
	--     --       local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
	--     --       return message
	--     --     end,
	--     --   },
	--     -- }, neotest_ns)
	--     require("neotest").setup({
	--       adapters = {
	--         ["neotest-python"] = {
	--           -- https://github.com/nvim-neotest/neotest-python
	--           runner = "pytest",
	--           args = { "--log-level", "INFO", "--color", "yes", "-vv", "-s" },
	--           -- dap = { justMyCode = false },
	--         },
	--         ["neotest-go"] = {
	--           args = { "-coverprofile=coverage.out" },
	--         },
	--         -- ["neotest-rust"] = {
	--         --   -- see lazy.lua
	--         --   -- https://github.com/rouge8/neotest-rust
	--         --   --
	--         --   -- requires nextest, which can be installed via "cargo binstall":
	--         --   -- https://github.com/cargo-bins/cargo-binstall
	--         --   -- https://nexte.st/book/pre-built-binaries.html
	--         -- },
	--         ["neotest-mocha"] = {
	--           -- https://github.com/adrigzr/neotest-mocha
	--           filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	--           command = "npm test --",
	--           env = { CI = true },
	--           cwd = function(_) -- skipped arg is path
	--             return vim.fn.getcwd()
	--           end,
	--         },
	--         ["neotest-vim-test"] = {
	--           -- https://github.com/nvim-neotest/neotest-vim-test
	--           ignore_file_types = { "python", "vim", "lua", "rust", "go" },
	--         },
	--       },
	--     })
	--   end,
	--   -- keys = {
	--   --   {
	--   --     "<leader>tS",
	--   --     ":lua require('neotest').run.run({ suite = true })<CR>",
	--   --     desc = "Run all tests in suite",
	--   --   },
	--   -- },
	--   -- function()
	--   --   require("neotest").run.run(vim.fn.expand("%"))
	--   -- end,
	-- },
	--
	-- {
	--   "andythigpen/nvim-coverage",
	--   dependencies = { "nvim-lua/plenary.nvim" },
	--   keys = {
	--     { "<leader>tc", "<cmd>Coverage<cr>", desc = "Coverage in gutter" },
	--     { "<leader>tC", "<cmd>CoverageLoad<cr><cmd>CoverageSummary<cr>", desc = "Coverage summary" },
	--   },
	--   config = function()
	--     require("coverage").setup({
	--       auto_reload = true,
	--     })
	--   end,
	-- },

	-- {
	--   "nvim-neotest/neotest",
	--   ft = { "go", "rust", "python", "cs", "typescript", "javascript" },
	--   dependencies = {
	--     "nvim-neotest/neotest-go",
	--     "nvim-neotest/neotest-python",
	--     "rouge8/neotest-rust",
	--     "Issafalcon/neotest-dotnet",
	--     "nvim-neotest/neotest-jest",
	--     "nvim-lua/plenary.nvim",
	--     "antoinemadec/FixCursorHold.nvim",
	--   },
	--   opts = function()
	--     return {
	--       adapters = {
	--         require("neotest-python"),
	--         require("neotest-rust"),
	--         require("neotest-go"),
	--         require("neotest-jest"),
	--         -- require("neotest-python")({
	--         --   -- Extra arguments for nvim-dap configuration
	--         --   -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
	--         --   dap = { justMyCode = false },
	--         --   -- Command line arguments for runner
	--         --   -- Can also be a function to return dynamic values
	--         --   args = { "--log-level", "DEBUG" },
	--         --   -- Runner to use. Will use pytest if available by default.
	--         --   -- Can be a function to return dynamic value.
	--         --   runner = "pytest",
	--         --   -- Custom python path for the runner.
	--         --   -- Can be a string or a list of strings.
	--         --   -- Can also be a function to return dynamic value.
	--         --   -- If not provided, the path will be inferred by checking for
	--         --   -- virtual envs in the local directory and for Pipenev/Poetry configs
	--         --   python = ".venv/bin/python",
	--         --   -- Returns if a given file path is a test file.
	--         --   -- NB: This function is called a lot so don't perform any heavy tasks within it.
	--         --   -- is_test_file = function(file_path)
	--         --   -- ...
	--         --   -- end,
	--         --   -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
	--         --   -- instances for files containing a parametrize mark (default: false)
	--         --   pytest_discover_instances = true,
	--         -- }),
	--       },
	--     }
	--   end,
	--   config = function(_, opts)
	--     -- get neotest namespace (api call creates or returns namespace)
	--     local neotest_ns = vim.api.nvim_create_namespace("neotest")
	--     vim.diagnostic.config({
	--       virtual_text = {
	--         format = function(diagnostic)
	--           local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
	--           return message
	--         end,
	--       },
	--     }, neotest_ns)
	--     require("neotest").setup(opts)
	--   end,
	-- },
}
