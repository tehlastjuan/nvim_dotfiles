local plugin_dir = vim.fn.stdpath("data") .. "/lazy/"
local lazypath = plugin_dir .. "/lazy.nvim"

-- Bootstrap lazy.nvim
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

---@type vim.Option
vim.opt.rtp:prepend(lazypath)

local plugin_specs = {
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- core
	require("plugins.blink"),
	require("plugins.lsp"),
	require("plugins.conform"),
	require("plugins.gitsigns"),
	require("plugins.diffview"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.which-key"),
	require("plugins.ibl"),
	require("plugins.todo-comments"),
	require("plugins.trouble"),

	-- utilities
	require("plugins.utils"),

	-- common lsp
	require("plugins.lang.markdown"),
	require("plugins.lang.json"),
	require("plugins.lang.yaml"),
	require("plugins.lang.toml"),
	require("plugins.lang.clangd"),
	require("plugins.lang.cmake"),
	require("plugins.lang.docker"),
	require("plugins.lang.tex"),

	-- lazy extras stuff
	--require("plugins.extras.dap.core"),
	--require("plugins.extras.editor.leap"),
	--require("plugins.extras.formatting.prettier"),
	--require("plugins.extras.editor.inc-rename"),

	-- additional lsp
	--require("plugins.lang.ansible"),
	--require("plugins.lang.php"),
	--require("plugins.lang.python"),
	--require("plugins.lang.typescript"),
	--require("plugins.lang.java")
	--require("plugins.lang.clisp")
	--require("plugins.lang.prolog")
}

-- Configure plugins.
require("lazy").setup({
	spec = plugin_specs,
	build = {
		warn_on_override = true,
	},
	rocks = {
		enabled = false,
	},
	install = {
		missing = false,
	},
	change_detection = {
		notify = false,
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
	},
	ui = {
		icons = require("icons").lazy,
	},
})
