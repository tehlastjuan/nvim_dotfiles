-- Install package manager / `:help lazy.nvim.txt` / https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- import plugins
		{ import = "lazyvim.plugins" },
	},
	defaults = {
		lazy = false,
		version = false, -- always use the latest git commit
		autocmds = false, -- lazyvim.config.autocmds
		keymaps = false, -- lazyvim.config.keymaps
		-- if you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua
	},
	news = {
		lazyvim = false,
		-- neovim = false,
	},
	performance = {
		cache = {
			enabled = true,
			-- disable_events = {},
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
