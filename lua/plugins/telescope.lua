local utils = require("utils")

local c_actions = {}

function c_actions.send_to_qflist(prompt_bufnr)
	require("telescope.actions").send_to_qflist(prompt_bufnr)
	vim.api.nvim_command([[ botright copen ]])
end

function c_actions.smart_send_to_qflist(prompt_bufnr)
	require("telescope.actions").smart_send_to_qflist(prompt_bufnr)
	vim.api.nvim_command([[ botright copen ]])
end

--- Scroll the results window up
---@param prompt_bufnr number: The prompt bufnr
function c_actions.results_scrolling_up(prompt_bufnr)
	c_actions.scroll_results(prompt_bufnr, -1)
end

--- Scroll the results window down
---@param prompt_bufnr number: The prompt bufnr
function c_actions.results_scrolling_down(prompt_bufnr)
	c_actions.scroll_results(prompt_bufnr, 1)
end

---@param prompt_bufnr number: The prompt bufnr
---@param direction number: 1|-1
function c_actions.scroll_results(prompt_bufnr, direction)
	local status = require("telescope.state").get_status(prompt_bufnr)
	local default_speed = vim.api.nvim_win_get_height(status.results_win) / 2
	local speed = status.picker.layout_config.scroll_speed or default_speed

	require("telescope.actions.set").shift_selection(prompt_bufnr, math.floor(speed) * direction)
end

return {

	-- Fuzzy finder.
	{
		"nvim-telescope/telescope.nvim",
		version = false,
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		keys = {
			{
				"<leader><space>",
				function()
					require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Find Files (Relative Dir)",
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").live_grep({ cwd = require("telescope.utils").buffer_dir() })
				end,
				desc = "Grep (Relative Dir)",
			},
			{
				"<leader>z",
				function()
					require("telescope").extensions.zoxide.list({
						prompt_title = "Zoxide",
						previewer = false,
						layout_config = { width = 0.6, height = 0.6 },
					})
				end,
				desc = "Find Files (Zoxide)",
			},

			-- find
			{
				"<leader>fc",
				function()
					require("telescope.builtin").find_files({ cwd = utils.config_files() })
				end,
				desc = "Find Config Files",
			},
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (Git)" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Files (Recent)" },
			-- git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
			-- search
			{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
			{ "<leader>sC", "<cmd>Telescope command_history<cr>", desc = "Search Command History" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help Pages" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Key Maps" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Search Man Pages" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Search Vim Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume Action" },

			{ "<leader>xj", "<cmd>Telescope jumplist<cr>", desc = "Goto Jumplist" },
			{ "<leader>xl", "<cmd>Telescope loclist<cr>", desc = "Goto Location List" },
			{ "<leader>xq", "<cmd>Telescope quickfix<cr>", desc = "Goto Quickfix List" },
		},
		opts = function()
			local actions = require("telescope.actions")

			local open_with_trouble = function(...)
				local file_type = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_get_current_buf() })
				print(vim.inspect(file_type) .. " " .. vim.inspect(...))
				return require("trouble.sources.telescope").open(...)
			end

			local function find_command()
				if 1 == vim.fn.executable("rg") then
					return { "rg", "--files", "--color", "never", "-g", "!.git" }
				elseif 1 == vim.fn.executable("fd") then
					return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
				elseif 1 == vim.fn.executable("fdfind") then
					return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
				elseif 1 == vim.fn.executable("find") and vim.fn.has("win32") == 0 then
					return { "find", ".", "-type", "f" }
				elseif 1 == vim.fn.executable("where") then
					return { "where", "/r", ".", "*" }
				end
			end

			local path_sep = jit and (jit.os == "Windows" and "\\" or "/") or package.config:sub(1, 1)

			return {
				defaults = {
					prompt_prefix = " ",
					selection_caret = "▍ ",
					multi_icon = " ",

					path_display = { "truncate" },
					file_ignore_patterns = { "node_modules" },
					set_env = { COLORTERM = "truecolor" },

					-- open files in the first window that is an actual file.
					-- use the current window if no other window is available.
					get_selection_window = function()
						local wins = vim.api.nvim_list_wins()
						table.insert(wins, 1, vim.api.nvim_get_current_win())
						for _, win in ipairs(wins) do
							local buf = vim.api.nvim_win_get_buf(win)
							if vim.bo[buf].buftype == "" then
								return win
							end
						end
						return 0
					end,

					sorting_strategy = "descending",
					layout_strategy = "vertical",
					results_title = false,
					prompt_title = false,
					dynamic_preview_title = false,
					layout_config = {
						anchor = "S",
						width = 0.8,
						height = 0.9,
						preview_cutoff = 1,
						preview_height = 0.6,
						prompt_position = "bottom",
					},

					history = {
						path = vim.fn.stdpath("state") .. path_sep .. "telescope_history",
					},

					mappings = {
						i = {
							["<c-t>"] = open_with_trouble,
							["<a-t>"] = open_with_trouble,

							["<C-Down>"] = actions.cycle_history_next,
							["<C-Up>"] = actions.cycle_history_prev,
							--["<C-d>"] = actions.preview_scrolling_down,
							--["<C-u>"] = actions.preview_scrolling_up,

							["<Tab>"] = actions.move_selection_worse,
							["<C-Tab>"] = actions.move_selection_better,

							["<C-u>"] = actions.results_scrolling_up,
							["<C-d>"] = actions.results_scrolling_down,

							--['<C-q>'] = c_actions.smart_send_to_qflist,

							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,

							["<C-b>"] = actions.preview_scrolling_up,
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
							["<C-j>"] = actions.preview_scrolling_down,
							["<C-h>"] = actions.preview_scrolling_left,
							["<C-l>"] = actions.preview_scrolling_right,
						},
						n = {
							["<Esc>"] = actions.close,
							["q"] = actions.close,

							["<Tab>"] = actions.move_selection_worse,
							["<C-Tab>"] = actions.move_selection_better,
							["<C-u>"] = c_actions.results_scrolling_up,
							["<C-d>"] = c_actions.results_scrolling_down,

							["<C-b>"] = actions.preview_scrolling_up,
							["<C-f>"] = actions.preview_scrolling_down,
							["<C-h>"] = actions.preview_scrolling_left,
							["<C-j>"] = actions.preview_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
							["<C-l>"] = actions.preview_scrolling_right,

							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,

							["*"] = actions.toggle_all,
							["u"] = actions.drop_all,
							["J"] = actions.toggle_selection + actions.move_selection_next,
							["K"] = actions.toggle_selection + actions.move_selection_previous,
							[" "] = {
								actions.toggle_selection + actions.move_selection_next,
								type = "action",
								opts = { nowait = true },
							},

							["sv"] = actions.select_horizontal,
							["sg"] = actions.select_vertical,
							["st"] = actions.select_tab,

							["w"] = c_actions.smart_send_to_qflist,
							["e"] = c_actions.send_to_qflist,

							["!"] = actions.edit_command_line,

							["t"] = open_with_trouble,

							["p"] = function()
								local entry = require("telescope.actions.state").get_selected_entry()
								require("rafi.util.preview").open(entry.path)
							end,

							-- Compare selected files with diffprg
							["c"] = function(prompt_bufnr)
								if #vim.g.diffprg == 0 then
									print("Set `g:diffprg` to use this feature")
									return
								end
								local from_entry = require("telescope.from_entry")
								local action_state = require("telescope.actions.state")
								local picker = action_state.get_current_picker(prompt_bufnr)
								local entries = {}
								for _, entry in ipairs(picker:get_multi_selection()) do
									table.insert(entries, from_entry.path(entry, false, false))
								end
								if #entries > 0 then
									table.insert(entries, 1, vim.g.diffprg)
									vim.fn.system(entries)
								end
							end,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = find_command,
						hidden = true,
						--theme = require("telescope.themes"):get_custom() and "custom" or "",
					},
				},
				extensions = {
					zoxide = {
						prompt_title = "[ Zoxide directories ]",
						mappings = {
							default = {
								action = function(selection)
									require("telescope.builtin").find_files({ cwd = selection.path })
								end,
								after_action = function(selection)
									vim.notify(selection.path, vim.log.levels.INFO)
								end,
							},
						},
					},
				},
			}
		end,
	},
}
