return {

	-- better diagnostics list and others
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{
				"<leader>xx",
				function()
					require("trouble").open("diagnostics")
				end,
				desc = "Diagnostics",
			},
      {
				"<c-'>",
				function()
					if require("trouble").is_open() == false then
						require("trouble").open("diagnostics")
					end
					---@diagnostic disable-next-line: missing-parameter, missing-fields
					require("trouble").prev({ skip_groups = true, jump = true })
				end,
				desc = "Previous Trouble Item",
			},
			{
				"<c-`>",
				function()
					if require("trouble").is_open() == false then
						require("trouble").open("diagnostics")
					end
					---@diagnostic disable-next-line: missing-parameter, missing-fields
					require("trouble").next({ skip_groups = true, jump = true })
				end,
				desc = "Next Trouble Item",
			},
		},
		opts = {
			modes = {
				diagnostics = {
					auto_close = true, -- auto close when there are no items
					auto_preview = false, -- automatically open preview when on an item
					filter = { buf = 0 }, -- filter diagnostics to the current buffer
					restore = false,
					sort = { "severity", "pos" },
					use_diagnostic_signs = true,
					--open_no_results = true,
					--warn_no_results = false,
					win = {
						type = "split",
						relative = "editor",
						position = "bottom",
						size = { height = 10 },
					},
				},
				---@diagnostic disable-next-line: missing-fields
				symbols = {
					restore = true,
					follow = true,
					win = {
						type = "split",
						relative = "editor",
						position = "bottom",
						size = { height = 10 },
					},
				},
				---@diagnostic disable-next-line: missing-fields
				lsp_document_symbols = {
					pinned = true,
					win = {
						type = "split",
						relative = "editor",
						position = "bottom",
						size = { height = 10},
					},
				},
        todo = {
					pinned = true,
					win = {
						type = "split",
						relative = "editor",
						position = "bottom",
						size = { height = 10},
					},
				},
				--  preview = {
				--    type = "float",
				--    relative = "editor",
				--    border = "rounded",
				--    -- title = "Preview",
				--    -- title_pos = "center",
				--    position = { 2, 46 },
				--    size = { width = 90, height = 25 },
				--    zindex = 200,
				--  },
				--},
				-- cascade = {
				--   mode = "diagnostics", -- inherit from diagnostics mode
				--   filter = function(items)
				--     local severity = vim.diagnostic.severity.HINT
				--     for _, item in ipairs(items) do
				--       severity = math.min(severity, item.severity)
				--     end
				--     return vim.tbl_filter(function(item)
				--       return item.severity == severity
				--     end, items)
				--   end,
				-- },
			},
		},
	},
}
