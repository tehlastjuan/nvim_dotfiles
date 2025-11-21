vim.filetype.add({ extension = { mdx = "markdown.mdx" } })

return {

	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				["markdown-toc"] = {
					condition = function(_, ctx)
						for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
							if line:find("<!%-%- toc %-%->") then
								return true
							end
						end
					end,
				},
				["markdownlint-cli2"] = {
					condition = function(_, ctx)
						local diag = vim.tbl_filter(function(d)
							return d.source == "markdownlint"
						end, vim.diagnostic.get(ctx.buf))
						return #diag > 0
					end,
				},
			},
			formatters_by_ft = {
				["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
				["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
			},
		},
	},

	--{
	--  "mfussenegger/nvim-lint",
	--  optional = true,
	--  opts = {
	--    linters_by_ft = {
	--      markdown = { "markdownlint-cli2" },
	--    },
	--  },
	--},

	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		servers = {
	-- 			marksman = {},
	-- 		},
	-- 	},
	-- },

	-- {
	-- 	"brianhuster/live-preview.nvim",
	-- 	dependencies = {
	-- 		-- You can choose one of the following pickers
	-- 		"nvim-telescope/telescope.nvim",
	-- 		-- "ibhagwan/fzf-lua",
	-- 		-- "echasnovski/mini.pick",
	-- 		-- "folke/snacks.nvim",
	-- 	},
	-- 	cmd = { "LivePreview start", "LivePreview close", "LivePreview pick" },
	-- 	ft = { "markdown" },

	-- 	config = function()
	-- 		require("livepreview.config").set({
	-- 			port = 5500,
	-- 			browser = "brave",
	-- 			dynamic_root = false,
	-- 			sync_scroll = true,
	-- 			picker = "telescope",
	-- 			address = "127.0.0.1",
	-- 		})
	-- 	end,
	-- 	keys = {
	-- 		{
	-- 			"<leader>cp",
	-- 			ft = "markdown",
	-- 			"<cmd>LivePreview start<cr>",
	-- 			desc = "LivePreview",
	-- 		},
	-- 	},
	-- },

	-- Markdown preview - https://github.com/iamcco/markdown-preview.nvim/issues/695
	-- cd ~/.local/share/nvim/lazy/markdown-preview.nvim
	-- npm install / yarn
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = ":call mkdp#util#install()",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_browser = "/usr/bin/brave"
		end,
		ft = { "markdown" },
		keys = {
			{
				"<leader>cp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		--config = function()
		--	vim.cmd([[do FileType]])
		--end,
	},
}
