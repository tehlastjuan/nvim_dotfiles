return {

	{ -- Autocompletion
		"saghen/blink.cmp",
		version = "*",
    build = 'cargo +nightly build --release',
		event = "VimEnter",
		dependencies = {
			--{
			--	"saghen/blink.compat",
			--	optional = true,
			--	version = "*",
			--	opts = {},
			--},
			"L3MON4D3/LuaSnip",
      --"rafamadriz/friendly-snippets",
			--"folke/lazydev.nvim",
		},
		--- @module 'blink.cmp'
		--- @type blink.cmp.Config
		opts = {
			keymap = {
				--preset = "enter",
				--["<cr>"] = { "select_and_accept", "fallback" },
				--["<c-y>"] = { "accept", "fallback" },
				["<cr>"] = { "accept", "fallback" },
				["<C-\\>"] = { "hide", "fallback" },
				["<c-n>"] = { "select_next", "show" },
				["<tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<c-tab>"] = { "select_prev" },
				["<c-p>"] = { "select_prev" },
				["<c-b>"] = { "scroll_documentation_up", "fallback" },
				["<c-f>"] = { "scroll_documentation_down", "fallback" },
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
			},
			appearance = {
				kind_icons = require("icons").kinds,
				--use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = true },
				list = {
					selection = { preselect = false, auto_insert = true },
					--max_items = 10,
				},
			},
			sources = {
				providers = {
					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
				},
				--per_filetype = {},

				-- Disable some sources in comments and strings.
				default = function()
					local sources = { "lsp", "buffer", "lazydev" }
					local ok, node = pcall(vim.treesitter.get_node)

					if ok and node then
						if not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
							table.insert(sources, "path")
						end
						if node:type() ~= "string" then
							table.insert(sources, "snippets")
						end
					end

					return sources
				end,
			},
			fuzzy = { implementation = "lua" },
			snippets = { preset = "luasnip" },
			signature = { enabled = true },
      opts_extend = { "sources.default"}
		},

		config = function(_, opts)
			require("blink.cmp").setup(opts)

			-- Extend neovim's client capabilities with the completion ones.
			vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
		end,
	},

	-- Snippets.
	{
		"L3MON4D3/LuaSnip",
		--version = "2.*",
		--build = (function() return "make install_jsregexp" end)(),
		--dependencies = {
		--	{
		--		"rafamadriz/friendly-snippets",
		--		config = function()
		--			require("luasnip.loaders.from_vscode").lazy_load()
		--		end,
		--	},
		--},
		keys = {
			{
				"<C-r>s",
				function()
					require("luasnip.extras.otf").on_the_fly("s")
				end,
				desc = "Insert on-the-fly snippet",
				mode = "i",
			},
		},
		opts = function()
			local types = require("luasnip.util.types")
			return {
				-- Check if the current snippet was deleted.
				delete_check_events = "TextChanged",
				-- Display a cursor-like placeholder in unvisited nodes
				-- of the snippet.
				ext_opts = {
					[types.insertNode] = {
						unvisited = {
							virt_text = { { "|", "Conceal" } },
							virt_text_pos = "inline",
						},
					},
					[types.exitNode] = {
						unvisited = {
							virt_text = { { "|", "Conceal" } },
							virt_text_pos = "inline",
						},
					},
					[types.choiceNode] = {
						active = {
							virt_text = { { "(snippet) choice node", "LspInlayHint" } },
						},
					},
				},
			}
		end,
		config = function(_, opts)
			local luasnip = require("luasnip")

			---@diagnostic disable: undefined-field
			luasnip.setup(opts)

			-- Load my custom snippets:
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = vim.fn.stdpath("config") .. "/snippets",
			})

			-- Use <C-c> to select a choice in a snippet.
			vim.keymap.set({ "i", "s" }, "<C-c>", function()
				if luasnip.choice_active() then
					require("luasnip.extras.select_choice")()
				end
			end, { desc = "Select choice" })
			---@diagnostic enable: undefined-field
		end,
	},
}
