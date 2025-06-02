return {

  -- icons
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

  -- { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    opts = {
      -- Make the icon for query files more visible.
      override = {
        scm = {
          icon = '󰘧',
          color = '#A9ABAC',
          cterm_color = '16',
          name = 'Scheme',
        },
      },
    },
  },

}
