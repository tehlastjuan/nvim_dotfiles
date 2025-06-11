M = {}

M.luasnip = {

	-- add luasnip
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		build = "make install_jsregexp",
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({
						paths = { vim.fn.stdpath("config") .. "/snippets" },
					})
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},

	-- nvim-cmp integration
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		dependencies = { "saadparwaiz1/cmp_luasnip" },
		opts = function(_, opts)
			opts.snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			}
			table.insert(opts.sources, { name = "luasnip" })
		end,
		keys = {
			{
				"<tab>",
				function()
					require("luasnip").jump(1)
					--require("utils").cmp.actions.snippet_forward = function()
					--	if require("luasnip").jumpable(1) then
					--		vim.schedule(function()
					--			require("luasnip").jump(1)
					--		end)
					--		return true
					--	end
					--end
				end,
				mode = "s",
			},
			{
				"<c-tab>",
				function()
					require("luasnip").jump(-1)
					--require("utils").cmp.actions.snippet_stop = function()
					--	if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
					--		require("luasnip").unlink_current()
					--		return true
					--	end
					--end
				end,
				mode = { "i", "s" },
			},
		},
	},
}

M.snippets = {

	-- add nvim-snippets & friendly-snippets
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"garymjr/nvim-snippets",
				opts = { friendly_snippets = true },
				dependencies = { "rafamadriz/friendly-snippets" },
			},
		},
		opts = function(_, opts)
			opts.snippet = {
				expand = function(args)
					require("nvim-snippets").lsp_expand(args.body)
				end,
			}
			table.insert(opts.sources, { name = "nvim-snippets" })
		end,
		keys = {
			{
				"<tab>",
				function()
					if vim.snippet.active({ direction = 1 }) then
						vim.schedule(function()
							vim.snippet.jump(1)
						end)
						return
					end
					return "<tab>"
				end,
				expr = true,
				silent = true,
				mode = "i",
			},
			{
				"<tab>",
				function()
					vim.schedule(function()
						vim.snippet.jump(1)
					end)
				end,
				expr = true,
				silent = true,
				mode = "s",
			},
			{
				"<c-tab>",
				function()
					if vim.snippet.active({ direction = -1 }) then
						vim.schedule(function()
							vim.snippet.jump(-1)
						end)
						return
					end
					return "<c-tab>"
				end,
				expr = true,
				silent = true,
				mode = { "i", "s" },
			},
		},
	},
}

return M
