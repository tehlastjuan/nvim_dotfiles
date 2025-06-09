-- Set color theme
vim.cmd.colorscheme("mr-onedark")

-- Install Lazy.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
local rtp = vim.opt.rtp
rtp:prepend(lazypath)
--vim.opt.rtp = vim.opt.rtp ^ lazypath

require("options")
require("keymaps")
require("autocmds")
require("statusline")
require("lsp")

-- Configure plugins.
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { missing = false },
	change_detection = { notify = false },
	rocks = { enabled = false },
	build = { warn_on_override = true },
	profiling = { loader = false, require = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
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
