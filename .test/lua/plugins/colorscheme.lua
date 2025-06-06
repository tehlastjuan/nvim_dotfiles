local colors = {
  black = "#151820",
  bg = "#1e222a",
  bg0 = "#242b38",
  bg1 = "#2d3343",
  bg2 = "#343e4f",
  bg3 = "#363c51",
  bg5 = "#455574",
  bg6 = "#546178",
  bg7 = "#7d899f",

  fg = "#a5b0c5",

  grey = "#546178",
  light_grey = "#7d899f",

  -- cyan
  cyan = "#4dbdcb",
  bright_cyan = "#7adcd7",
  dark_cyan = "#25747d",

  -- green
  green = "#98c379",
  bright_green = "#ace98e",
  dark_green = "#303d27",

  -- blue
  blue = "#61afef",
  bright_blue = "#73ccfe",
  dark_blue = "#265478",

  -- magenta
  purple = "#ca72e4",
  bright_purple = "#da9ef2",
  dark_purple = "#8f36a9",
  transparent_blue = "#19272C",

  --orange
  orange = "#d99a5e",

  -- red
  red = "#be5046",
  bright_red = "#e06c75",
  dark_red = "#3c2729",

  -- yellow
  yellow = "#ebc275",
  bright_yellow = "#f0d197",
  dark_yellow = "#9a6b16",
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
        FoldColumn = { fg = colors.bg2, bg = colors.bg },
        Folded = { bg = colors.bg },

        -- Trouble background
        TroubleNormal = { bg = colors.bg }, -- NormalFloat = {fg = c.fg, bg = c.bg1},
        TroubleNormalNC = { bg = colors.bg }, -- NormalFloat = {fg = c.fg, bg = c.bg1},

        -- Neotree
        NeoTreeExpander = { bg = colors.bg },
        NeoTreeNormal = { bg = colors.bg },
        NeoTreeNormalNC = { bg = colors.bg },
        NeoTreeSignColumn = { bg = colors.bg },
        NeoTreeStats = { bg = colors.bg },
        NeoTreeStatsHeader = { bg = colors.bg },
        NeoTreeStatusLine = { fg = colors.bg3, bg = colors.bg },
        NeoTreeStatusLineNC = { fg = colors.bg3, bg = colors.bg },
        NeoTreeVertSplit = { fg = colors.bg3, bg = colors.bg },
        NeoTreeWinSeparator = { fg = colors.bg3, bg = colors.bg },
        NeoTreeEndOfBuffer = { bg = colors.bg },
        NeoTreeRootName = { bg = colors.bg },
        NeoTreeSymbolicLinkTarget = { bg = colors.bg },
        NeoTreeTitleBar = { bg = colors.bg },
        NeoTreeBufferNumber = { bg = colors.bg },
        -- NeoTreeCursorLine = { bg = colors.bg0 },
        NeoTreeDimText = { bg = colors.bg },
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
        WinBar = { fg = colors.light_grey, bg = colors.bg, italic = false, bold = false },
        WinBarNC = { bg = colors.bg },
        WinBarDir = { fg = colors.orange, bg = colors.bg, italic = false, bold = false },
        WinBarSeparator = { fg = colors.cyan, bg = colors.bg },

        StatuslineModeNormal = { fg = colors.bg, bg = colors.green, fmt = "bold" },
        StatuslineModePending = { fg = colors.bg, bg = colors.yellow, fmt = "bold" },
        StatuslineModeVisual = { fg = colors.bg, bg = colors.purple, fmt = "bold" },
        StatuslineModeInsert = { fg = colors.bg, bg = colors.blue, fmt = "bold" },
        StatuslineModeCommand = { fg = colors.bg, bg = colors.blue, fmt = "bold" },
        StatuslineModeOther = { fg = colors.bg, bg = colors.orange, fmt = "bold" },

        StatuslineSepNormal = { fg = colors.green, bg = colors.bg1 },
        StatuslineSepPending = { fg = colors.yellow, bg = colors.bg1 },
        StatuslineSepVisual = { fg = colors.purple, bg = colors.bg1 },
        StatuslineSepInsert = { fg = colors.blue, bg = colors.bg1 },
        StatuslineSepCommand = { fg = colors.blue, bg = colors.bg1 },
        StatuslineSepOther = { fg = colors.orange, bg = colors.bg1 },

        StatuslineRegular = { fg = colors.fg, bg = colors.bg1 },
        StatuslineItalic = { fg = colors.fg, bg = colors.bg1, fmt = "italic" },
        StatuslineBold = { fg = colors.fg, bg = colors.bg1, fmt = "bold" },
        StatuslineSpinner = { fg = colors.bright_green, bg = colors.bg1, fmt = "bold" },
        StatuslineDir = { fg = colors.orange, bg = colors.bg1, fmt = "bold" },

        DiagnosticError = { fg = colors.red }, --, bg = colors.bg1 },
        DiagnosticWarn = { fg = colors.yellow }, --, bg = colors.bg1 },
        DiagnosticHint = { fg = colors.green }, --, bg = colors.bg1 },
        DiagnosticInfo = { fg = colors.blue }, --, bg = colors.bg1 },

        StatuslineGitAdd = { fg = colors.bright_green, bg = colors.bg1 },
        StatuslineGitMod = { fg = colors.bright_blue, bg = colors.bg1 },
        StatuslineGitRem = { fg = colors.bright_red, bg = colors.bg1 },

        StatuslineFileMod = { fg = colors.bright_red, bg = colors.bg1 },
        StatuslineFileUnMod = { fg = colors.bg1, bg = colors.bg1 },

        StatuslineCols = { fg = colors.blue, bg = colors.bg1 },
        StatuslineLines = { fg = colors.fg, bg = colors.bg1 },

        StatusLine = { fg = colors.fg, bg = colors.bg1 },
        StatusLineTerm = { fg = colors.fg, bg = colors.bg1 },
        StatusLineNC = { fg = colors.grey, bg = colors.bg },
        StatusLineTermNC = { fg = colors.grey, bg = colors.bg },

        -- Misc
        NormalFloat = { bg = colors.bg1 },
        SnippetTabstop = { bg = colors.bg },
        FloatBorder = { fg = colors.bg3, bg = colors.bg },
        WhichKeyFloat = { bg = colors.bg1 },
        MasonNormal = { bg = colors.bg1 },
        LazyNormal = { bg = colors.bg1 },
        TelescopePromptNormal = { bg = colors.bg1 },
        BufferLineOffsetSeparator = { fg = colors.bg3, bg = colors.bg },
        -- LspInfoTip = { fg = colors.fg, bg = colors.bg1 },
      },
      colors = {
        bg0 = colors.bg,
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
