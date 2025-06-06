-- Install package manager :help lazy.nvim.txt
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.uv = vim.uv or vim.loop
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

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { missing = false },
  rocks = { enabled = false },
  defaults = { lazy = false, version = false },
  --news = { lazyvim = false, neovim = true },
  performance = {
    --cache = { enabled = true },
    --reset_packpath = true,
    --reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
    -----@type string[]
    --paths = {}, -- add any custom paths here that you want to includes in the rtp
    -----@type string[] list any plugins you want to disable here
    -- disable some rtp plugins
    rtp = {
      disabled_plugins = {
        "gzip",
        "vimballPlugin",
        "matchit",
        "matchparen",
        "2html_plugin",
        "tohtml",
        "tarPlugin",
        "netrwPlugin",
        "tutor",
        "zipPlugin",
      },
    },
  },
  change_detection = { notify = false },
  --readme = { enabled = false },
  state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
  build = { warn_on_override = true },
  profiling = { loader = false, require = false },
})
