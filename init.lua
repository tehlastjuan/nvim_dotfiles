-- Colorscheme
-- vim.cmd.colorscheme "custom-onedark"

-- Install package manager / `:help lazy.nvim.txt` / https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp = vim.opt.rtp ^ lazypath

-- Config files
require "options"
require "keymaps"
require "commands"
require "autocmds"
require "json"
require "winbar"
require "lsp"

-- Plugins config
require("lazy").setup({
  spec = {
    { import = "plugins" },
  -- { import = "plugins.extras" },
  },
  install = { missing = false, },
  change_detection = { notify = false },
  rocks = { enabled = false },
  performance = {
    --cache = {
    --  enabled = true,
    --  -- disable_events = {},
    --},
    --reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      --reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      --paths = {},          -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      -- disable some rtp plugins
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
  --state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
})
