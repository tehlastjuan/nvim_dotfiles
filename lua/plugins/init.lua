return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  -- JSON/YAML schemas.
  { 'b0o/SchemaStore.nvim', lazy = true },

  --
  -- {
  --   "echasnovski/mini.icons",
  --   lazy = true,
  --   opts = {},
  --   init = function()
  --     package.preload["nvim-web-devicons"] = function()
  --       require("mini.icons").mock_nvim_web_devicons()
  --       return package.loaded["nvim-web-devicons"]
  --     end
  --   end,
  -- },

}
