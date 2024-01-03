return {

  {
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 99, -- make sure to load this before all the other start plugins
    config = function()
      vim.g.onedark_config = { style = "cool" }
      vim.cmd.colorscheme("onedark")
    end,
  },

}
