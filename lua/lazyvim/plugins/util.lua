return {

	-- { "LazyVim/LazyVim", opts = { colorscheme = "onedark" } },

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

	{ "NvChad/nvim-colorizer.lua" },

	{
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				[[=================     ===============     ===============   ========  ========]],
				[[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
				[[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
				[[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
				[[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
				[[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
				[[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
				[[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
				[[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
				[[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
				[[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
				[[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
				[[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
				[[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
				[[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
				[[||.=='    _-'                                                     `' |  /==.||]],
				[[=='    _-'                        N E O V I M                         \/   `==]],
				[[\   _-'                                                                `-_   /]],
				[[ `''                                                                      ``' ]],
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
				dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
				dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
				dashboard.button("e", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
				dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
			}
		end,
	},

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
