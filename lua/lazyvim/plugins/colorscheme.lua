return {

	{
		"navarasu/onedark.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
			colors = {
				bg0 = "#1e222a",
			},
			diagnostics = {
				darker = true, -- darker colors for diagnostic
				undercurl = true, -- use undercurl instead of underline for diagnostics
				background = true, -- use background color for virtual text
			},
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			require("onedark").load()
			--
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
		end,
	},
}
