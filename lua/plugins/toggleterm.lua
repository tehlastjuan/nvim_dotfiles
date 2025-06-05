return {

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        -- Normal = { link = "CursorColumn" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 65,
      open_mapping = [[<c-/>]],
      terminal_mappings = true,
      shade_terminals = true,
      -- shading_factor = 0,
      direction = "vertical",
      close_on_exit = true,
      -- float_opts = {
      -- border = "single",
      -- highlights = { border = "Normal", background = "Normal" },
      -- },
    },
  },

}
