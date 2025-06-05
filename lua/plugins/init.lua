if vim.fn.has("nvim-0.9.0") == 0 then
  vim.api.nvim_echo({
    { "LazyVim requires Neovim >= 0.9.0\n", "ErrorMsg" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
  return {}
end

require("config").init()

require("statusline")

return {
  { "folke/lazy.nvim", version = "*" },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- { "LazyVim/LazyVim", priority = 10000, lazy = false, config = true, cond = true, version = "*" },
}
