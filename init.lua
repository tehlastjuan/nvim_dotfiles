local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Set color theme
vim.cmd.colorscheme("mr-onedark")

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
vim.opt.rtp:prepend(lazypath)

--_G.Utils = require("utils")

require "globals"
require "options"
require "keymaps"
require "commands"
require "autocmds"
require "statusline"
require "diagnostics"
require "lsp"

-- Configure plugins.
require("lazy").setup({
	spec = require("specs"),
	ui = {
    icons = require("icons").lazy
  },
	--build = {
  --  warn_on_override = true
  --},
	rocks = {
    enabled = false
  },
	install = {
    missing = false
  },
	change_detection = {
    notify = false
  },
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
		-- cache = {
		-- 	enabled = true,
		-- },
		-- reset_packpath = true,
	},
})

-- vim.cmd.packadd "nvim.undotree"
