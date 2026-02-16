----- Globals -----

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Disable auto format
vim.g.autoformat = false

-- Root dir detection. Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Setup the terminal to use * pwsh, * powershell
-- vim.opt.shell("pwsh")

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Disable loading certain plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_sql_completion = 1

-- Disable health checks for python/perl/ruby/node providers
-- vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Disable sql omni completion
vim.g.loaded_sql_completion = 1

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.g.yaml_indent_multiline_scalar = 1

-- See share/nvim/runtime/ftplugin/gitrebase.vim
vim.g.no_gitrebase_maps = 1

-- See share/nvim/runtime/ftplugin/man.vim
vim.g.no_man_maps = 1

-- If sudo, disable vim swap/backup/undo/shada writing
local USER = vim.env.USER or ""
local SUDO_USER = vim.env.SUDO_USER or ""
if
	SUDO_USER ~= ""
	and USER ~= SUDO_USER
	and vim.env.HOME ~= vim.fn.expand("~" .. USER, true)
	and vim.env.HOME == vim.fn.expand("~" .. SUDO_USER, true)
then
	vim.opt_global.modeline = false
	vim.opt_global.undofile = false
	vim.opt_global.swapfile = false
	vim.opt_global.backup = false
	vim.opt_global.writebackup = false
	vim.opt_global.shadafile = "NONE"
end

-- vim: set ts=2 sw=0 tw=80 noet :
