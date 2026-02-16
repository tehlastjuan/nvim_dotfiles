return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "b0o/SchemaStore.nvim", lazy = true },

	-- core
	require("plugins.blink"),
	require("plugins.lspconfig"),
	require("plugins.treesitter"),
	require("plugins.luasnip"),
	require("plugins.conform"),
	require("plugins.gitsigns"),
	require("plugins.telescope"),
	require("plugins.miniclue"),
	require("plugins.diffview"),
	require("plugins.ibl"),
	require("plugins.todo-comments"),
	require("plugins.trouble"),

	-- utilities
	require("plugins.utils"),

	-- common lsp
	-- require("plugins.lang.cmake"),
	--require("plugins.lang.clangd"),
	--require("plugins.lang.docker"),
	--require("plugins.lang.json"),
	require("plugins.lang.markdown"),
	require("plugins.lang.tex"),
	--require("plugins.lang.toml"),
	--require("plugins.lang.yaml"),

	-- lazy extras stuff
	--require("plugins.extras.dap.core"),
	--require("plugins.extras.editor.leap"),
	--require("plugins.extras.formatting.prettier"),
	--require("plugins.extras.editor.inc-rename"),

	-- additional lsp
	--require("plugins.lang.go"),
	--require("plugins.lang.ansible"),
	--require("plugins.lang.php"),
	--require("plugins.lang.python"),
	--require("plugins.lang.typescript"),
	--require("plugins.lang.java")
	--require("plugins.lang.clisp")
	--require("plugins.lang.prolog")
}
