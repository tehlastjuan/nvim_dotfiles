-- Set color theme
vim.cmd.colorscheme("mr-onedark")

_G.Utils = require("utils")

require("globals")
require("options")
require("keymaps")
require("autocmds")
require("diagnostics")
require("specs")
require("statusline")
