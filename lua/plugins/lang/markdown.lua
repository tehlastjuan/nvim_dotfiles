vim.filetype.add({ extension = { mdx = "markdown.mdx" } })

return {

	{
	  "mfussenegger/nvim-lint",
	  optional = true,
	  opts = {
	    linters_by_ft = {
	      markdown = { "markdownlint-cli2" },
	    },
	  },
	},

	-- Markdown preview - https://github.com/iamcco/markdown-preview.nvim/issues/695
	-- cd ~/.local/share/nvim/lazy/markdown-preview.nvim
  -- NODE_OPTIONS=--openssl-legacy-provider npm install / npm build
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
