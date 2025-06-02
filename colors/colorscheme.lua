-- local M = {}
--
-- function M.get_c()
--   local c = require("onedark.palette").cool
--   return c
-- end

return {

  {
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
      transparent = false, -- Show/hide background
      term_colors = false, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = true, -- reverse item kind highlights in cmp menu

      code_style = { -- italic, bold, underline, none
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },

      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      highlights = {
        -- trouble background
        TroubleNormal = { bg = "#1e222a" }, -- NormalFloat = {fg = c.fg, bg = c.bg1},
        TroubleNormalNC = { bg = "#1e222a" }, -- NormalFloat = {fg = c.fg, bg = c.bg1},
        -- neotree
        NeoTreeExpander = { bg = "#1e222a" },
        NeoTreeNormal = { bg = "#1e222a" },
        NeoTreeNormalNC = { bg = "#1e222a" },
        NeoTreeSignColumn = { bg = "#1e222a" },
        NeoTreeStats = { bg = "#1e222a" },
        NeoTreeStatsHeader = { bg = "#1e222a" },
        NeoTreeStatusLine = { fg = "#363c51", bg = "#1e222a" },
        NeoTreeStatusLineNC = { fg = "#363c51", bg = "#1e222a" },
        NeoTreeVertSplit = { fg = "#363c51", bg = "#1e222a" },
        NeoTreeWinSeparator = { fg = "#363c51", bg = "#1e222a" },
        NeoTreeEndOfBuffer = { bg = "#1e222a" },
        NeoTreeRootName = { bg = "#1e222a" },
        NeoTreeSymbolicLinkTarget = { bg = "#1e222a" },
        NeoTreeTitleBar = { bg = "#1e222a" },

        NeoTreeBufferNumber = { bg = "#1e222a" },
        -- NeoTreeCursorLine = { bg = "#1e222a" },
        NeoTreeDimText = { bg = "#1e222a" },
        -- NeoTreeDirectoryIcon = { bg = "#1e222a" },
        -- NeoTreeDirectoryName = { bg = "#1e222a" },
        -- NeoTreeDotfile = { bg = "#1e222a" },
        -- NeoTreeFileIcon = { bg = "#1e222a" },
        -- NeoTreeFileName = { bg = "#1e222a" },
        -- NeoTreeFileNameOpened = { bg = "#1e222a" },
        -- NeoTreeFilterTerm = { bg = "#1e222a" },
        NeoTreeFloatBorder = { fg = "#363c51", bg = "#242b38" },
        NeoTreeFloatTitle = { fg = "#a5b0c5", bg = "#242b38" },
        NeoTreeFloatNormal = { fg = "#a5b0c5", bg = "#242b38" },

        NormalFloat = { bg = "#242b38" },
        SnippetTabstop = { bg = "#1e222a" },
        FloatBorder = { fg = "#363c51", bg = "#1e222a" },
        WhichKeyFloat = { bg = "#242b38" },
        MasonNormal = { bg = "#242b38" },
        LazyNormal = { bg = "#242b38" },
        TelescopePromptNormal = { bg = "#242b38" },
        BufferLineOffsetSeparator = { fg = "#363c51", bg = "#1e222a" },
        -- LspInfoTip = { fg = "#a5b0c5", bg = "#242b38" },

      },

      colors = {
        bg0 = "#1e222a",
        -- bg1 = "#1e222a",
        -- bg2 = "#1e222a",
        -- bg3 = "#1e222a",
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

-- local c = require("onedark.colors")
-- local hl = require("onedark.highlights")
-- local cfg = vim.g.onedark_config
--
-- hl.plugins.trouble = {
-- 	-- TroubleCount = { bg = "#ff2222" },
-- 	-- TroubleError =  { bg = "#ffffff" },
-- 	-- TroubleNormal =  { bg = "#ffffff" },
-- 	-- -- TroubleTextInformation =  { bg = "#ffffff" },
-- 	-- TroubleSignWarning =  { bg = "#ffffff" },
-- 	-- TroubleLocation = { bg = "#1e222a" },
-- 	-- TroubleWarning =  { bg = "#ffffff" },
-- 	-- TroublePreview =  { bg = "#ffffff" },
-- 	TroubleTextError = { bg = cfg.transparent and c.none or c.bg0 },
-- 	-- TroubleSignInformation =  { bg = "#ffffff" },
-- 	-- TroubleIndent =  { bg = "#1e222a" },
-- 	-- TroubleSource =  { bg = "#1e222a" },
-- 	-- TroubleSignHint =  { bg = "#ffffff" },
-- 	-- TroubleSignOther =  { bg = "#ffffff" },
-- 	-- TroubleFoldIcon =  { bg = "#ffffff" },
-- 	-- TroubleTextWarning =  { bg = "#ffffff" },
-- 	-- TroubleCode =  { bg = "#1e222a" },
-- 	-- TroubleInformation =  { bg = "#ffffff" },
-- 	-- TroubleSignError =  { bg = "#1e222a" },
-- 	-- TroubleFile =  { bg = "#ffffff" },
-- 	-- TroubleHint =  { bg = "#ffffff" },
-- 	-- TroubleTextHint =  { bg = "#ffffff" },
-- 	-- TroubleText =  { bg = "#ffffff" },
-- }
--
-- require("onedark").setup({
-- 	highlights = {
-- 		-- black = "#151820",
-- 		-- bg0 = "#242b38",
-- 		-- bg1 = "#2d3343",
-- 		-- bg2 = "#343e4f",
-- 		-- bg3 = "#363c51",
-- 		-- bg_d = "#1e242e",
-- 		-- bg_blue = "#6db9f7",
-- 		-- bg_yellow = "#f0d197",
-- 		-- fg = "#a5b0c5",
-- 		-- purple = "#ca72e4",
-- 		-- green = "#97ca72",
-- 		-- orange = "#d99a5e",
-- 		-- blue = "#5ab0f6",
-- 		-- yellow = "#ebc275",
-- 		-- cyan = "#4dbdcb",
-- 		-- red = "#ef5f6b",
-- 		-- grey = "#546178",
-- 		-- light_grey = "#7d899f",
-- 		-- dark_cyan = "#25747d",
-- 		-- dark_red = "#a13131",
-- 		-- dark_yellow = "#9a6b16",
-- 		-- dark_purple = "#8f36a9",
-- 		-- diff_add = "#303d27",
-- 		-- diff_delete = "#3c2729",
-- 		-- diff_change = "#18344c",
-- 		-- diff_text = "#265478",
-- 		-- CursorLine = { "#1e222a" },
-- 	},
-- })
