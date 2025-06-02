local colors = {
    fg = "#a5b0c5",
    bg0 = "#1e222a",
    bg1 = "#242b38",
    bg2 = "#343e4f",
    bg3 = "#363c51",
    bg4 = "#546178",
}

return {

  {
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "cool",
      transparent = false,
      term_colors = false,
      ending_tildes = false,
      cmp_itemkind_reverse = true, -- reverse item kind highlights in cmp menu

      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none", -- italic, bold, underline, none
      },

      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      highlights = {

        -- Folds
        FoldColumn = { fg = colors.bg2, bg = colors.bg0 },
        Folded = { bg = colors.bg0 },

        -- Trouble background
        TroubleNormal = { bg = colors.bg0 }, -- NormalFloat = {fg = c.fg, bg = c.bg1},
        TroubleNormalNC = { bg = colors.bg0 }, -- NormalFloat = {fg = c.fg, bg = c.bg1},

        -- Neotree
        NeoTreeExpander = { bg = colors.bg0 },
        NeoTreeNormal = { bg = colors.bg0 },
        NeoTreeNormalNC = { bg = colors.bg0 },
        NeoTreeSignColumn = { bg = colors.bg0 },
        NeoTreeStats = { bg = colors.bg0 },
        NeoTreeStatsHeader = { bg = colors.bg0 },
        NeoTreeStatusLine = { fg = colors.bg3, bg = colors.bg0 },
        NeoTreeStatusLineNC = { fg = colors.bg3, bg = colors.bg0 },
        NeoTreeVertSplit = { fg = colors.bg3, bg = colors.bg0 },
        NeoTreeWinSeparator = { fg = colors.bg3, bg = colors.bg0 },
        NeoTreeEndOfBuffer = { bg = colors.bg0 },
        NeoTreeRootName = { bg = colors.bg0 },
        NeoTreeSymbolicLinkTarget = { bg = colors.bg0 },
        NeoTreeTitleBar = { bg = colors.bg0 },
        NeoTreeBufferNumber = { bg = colors.bg0 },
        -- NeoTreeCursorLine = { bg = colors.bg0 },
        NeoTreeDimText = { bg = colors.bg0 },
        -- NeoTreeDirectoryIcon = { bg = colors.bg0 },
        -- NeoTreeDirectoryName = { bg = colors.bg0 },
        -- NeoTreeDotfile = { bg = colors.bg0 },
        -- NeoTreeFileIcon = { bg = colors.bg0 },
        -- NeoTreeFileName = { bg = colors.bg0 },
        -- NeoTreeFileNameOpened = { bg = colors.bg0 },
        -- NeoTreeFilterTerm = { bg = colors.bg0 },
        NeoTreeFloatBorder = { fg = colors.bg3, bg = colors.bg1 },
        NeoTreeFloatTitle = { fg = colors.fg, bg = colors.bg1 },
        NeoTreeFloatNormal = { fg = colors.fg, bg = colors.bg1 },

        -- Winbar styling.
        WinBar = { fg = colors.fg, bg = colors.bg0 },
        WinBarNC = { bg = colors.bg0 },
        WinBarDir = { fg = colors.bright_cyan, bg = colors.bg0, italic = true },
        WinBarSeparator = { fg = colors.cyan, bg = colors.bg0 },

        -- Misc
        NormalFloat = { bg = colors.bg1 },
        SnippetTabstop = { bg = colors.bg0 },
        FloatBorder = { fg = colors.bg3, bg = colors.bg0 },
        WhichKeyFloat = { bg = colors.bg1 },
        MasonNormal = { bg = colors.bg1 },
        LazyNormal = { bg = colors.bg1 },
        TelescopePromptNormal = { bg = colors.bg1 },
        BufferLineOffsetSeparator = { fg = colors.bg3, bg = colors.bg0 },
        -- LspInfoTip = { fg = colors.fg, bg = colors.bg1 },
      },
      colors = {
        bg0 = colors.bg0,
      },
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      vim.cmd("colorscheme onedark")
    end,
  },
}
