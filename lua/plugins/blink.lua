-- Autocompletion
return {
	{
		"saghen/blink.cmp",
		build = "cargo +nightly build --release",
		event = "VimEnter",
		dependencies = {
			"LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		opts = {
			appearance = {
				kind_icons = require("icons").kinds,
				nerd_font_variant = "mono",
			},
			completion = {
				documentation = { auto_show = true },
				list = {
					selection = { preselect = false, auto_insert = true },
					--max_items = -1,
				},
				menu = {
					scrollbar = false,
					draw = {
						gap = 2,
						columns = {
							{ "kind_icon", "kind", gap = 1 },
							{ "label", "label_description", gap = 1 },
						},
					},
				},
			},
			keymap = {
				["<cr>"] = { "accept", "fallback" },
				["<C-Esc>"] = { "hide", "fallback" },
				["<c-n>"] = { "select_next", "show" },
				["<tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<c-p>"] = { "select_prev", "show" },
				["<c-h>"] = { "scroll_documentation_up", "fallback" },
				["<c-l>"] = { "scroll_documentation_down", "fallback" },
				-- All presets have the following mappings:
				-- <tab>/<s-tab>: move to right/left of your snippet expansion
				-- <c-space>: Open menu or open docs if already open
				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
				-- <c-e>: Hide menu
				-- <c-k>: Toggle signature help
			},
			--opts_extend = { "sources.default" },
			signature = { enabled = true },
			-- snippets = {
			-- 	luasnip = true,
			-- 	friendly_snippets = true,
			-- },
			sources = {
				providers = {
					snippets = {
						opts = { friendly_snippets = true, luasnip = true },
					},
				},

				-- Disable some sources in comments and strings.
				default = function()
					local sources = { "lsp", "buffer" }
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
		},
		--config = function(_, opts)
		--	require("blink.cmp").setup(opts)
		--	-- Extend neovim's client capabilities with the completion ones.
		--	vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
		--end,
	},
}
