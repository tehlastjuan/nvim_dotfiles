local utils = require("utils")

-- Source current config
vim.keymap.set("n", "<leader>cs", function()
  vim.cmd(":source " .. utils.config_files() .. "/init.lua")
end, { desc = "Source current config" })

-- Exit insert mode
vim.keymap.set("i", "jk", "<esc>", { desc = "ESC" })
vim.keymap.set("i", "kj", "<esc>", { desc = "ESC" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Window management
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>wj", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>wl", "<C-W>v", { desc = "Split window right", remap = true })

-- Window debug
vim.keymap.set("n", "<leader>wx", function()
	print(vim.inspect(vim.api.nvim_get_current_win()))
end, { desc = "Get current window" })

vim.keymap.set("n", "<leader>wy", function()
	print(vim.inspect(vim.api.nvim_list_bufs()))
end, { desc = "List buffers" })

vim.keymap.set("n", "<leader>wz", function()
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		print("win:" .. w .. "\n" .. vim.inspect(vim.api.nvim_win_get_config(w)))
		local file_type = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(w) })
		print("filetype:" .. vim.inspect(file_type))
	end
end, { desc = "List windows" })

-- Buffers
vim.keymap.set("n", "<c-,>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<c-.>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<c-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<c-s-tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
--vim.keymap.set("n", "<leader>bd", "<cmd>:bdelete<cr>", { desc = "Delete Buffer" })

--  Tabs
vim.keymap.set("n", "<c-s-,>", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "<c-s-.>", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- Move Lines
vim.keymap.set("n", "<c-s-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<c-s-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<c-s-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<c-s-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<c-s-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<c-s-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Clear tool windows with S + <esc>
vim.keymap.set({ "i", "n" }, "<s-esc>", function()
	-- close any trouble windows
	if require("trouble").is_open() then
		require("trouble").close()
	end
	-- clear hl search
	vim.cmd(":noh")
	-- clears prompt
	vim.print("")
end, { desc = "Clear work area" })

-- Clear search
vim.keymap.set({ "n", "v" }, "<leader>ch", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw, taken from runtime/lua/_editor.lua
vim.keymap.set(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

-- Close all buffers and quit
vim.keymap.set({ "n", "v" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Show highlights under cursor
vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Easy mode
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Up>", "<Nop>", { desc = "NOP" })
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Left>", "<Nop>", { desc = "NOP" })
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Right>", "<Nop>", { desc = "NOP" })
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Down>", "<Nop>", { desc = "NOP" })

----- Plugins -----

-- Plugin manager
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true, desc = "Lazy" })

-- Lsp server manager
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { silent = true, desc = "Mason" })

-- Web-tools
vim.keymap.set("n", "<leader>cb", "<cmd>BrowserOpen<cr>", { desc = "Browser Preview", remap = true })

-- Toggleterm
vim.keymap.set("n", "<C-/>", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", { desc = "Toggleterm h-split" })
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm<cr>", { desc = "Toggleterm v-split" })
vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggleterm float" })

vim.keymap.set("n", "<leader>tl", function()
	require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
end, { desc = "Send selection to Terminal" })

vim.keymap.set("v", "<leader>tv", function()
	require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
end, { desc = "Send visual lines to Terminal" })

vim.keymap.set("v", "<leader>ts", function()
	require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
end, { desc = "Send visual selection to Terminal" })

-- Formatting
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "Format" })

vim.keymap.set({ "n", "v" }, "<leader>cF", function()
	require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
end, { desc = "Format Injected Langs" })

-- Trouble
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").open("diagnostics")
end, { desc = "Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>.", function()
	--vim.cmd('Telescope buffers sort_mru=true sort_lastused=true')
	--require("telescope.builtin").buffers()

	vim.cmd(":enew | !ls")
	local wins = utils.fetch_ft_windows("")
	local buf = vim.api.nvim_win_get_buf(wins[1])
	print(vim.inspect(buf))
	require("trouble.sources.telescope").open(buf)
	--vim.defer_fn(function()
	--  require("trouble.sources.telescope").open(buf)
	--end, 50)

	--require("trouble").open("telescope_files")
	--require("trouble.sources.telescope").open(buf)
end, { desc = "Switch Buffer (Trouble)" })

--vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
--vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
--vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

vim.keymap.set("n", "<c-'>", function()
	if require("trouble").is_open() == false then
		require("trouble").open("diagnostics")
	else
		---@diagnostic disable-next-line: missing-parameter, missing-fields
		require("trouble").prev({ skip_groups = true, jump = true })
	end
end, { desc = "Previous Trouble Item" })

vim.keymap.set("n", "<c-`>", function()
	if require("trouble").is_open() == false then
		require("trouble").open("diagnostics")
	else
		---@diagnostic disable-next-line: missing-parameter, missing-fields
		require("trouble").next({ skip_groups = true, jump = true })
	end
end, { desc = "Next Trouble Item" })

-- Lazygit
--vim.keymap.set("n", "<leader>ga", function()
--  LazyVim.terminal({ "lazygit" }, { cwd = LazyVim.root(), esc_esc = false, ctrl_hjkl = false })
--end, { desc = "Lazygit (root dir)" })
--
--vim.keymap.set("n", "<leader>gA", function()
--  LazyVim.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
--end, { desc = "Lazygit (cwd)" })
--
--vim.keymap.set("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
--vim.keymap.set("n", "<leader>gB", LazyVim.lazygit.browse, { desc = "Git Browse" })
--
--vim.keymap.set("n", "<leader>gf", function()
--  local git_path = vim.api.nvim_buf_get_name(0)
--  LazyVim.lazygit({ args = { "-f", vim.trim(git_path) } })
--end, { desc = "Lazygit Current File History" })
--
--vim.keymap.set("n", "<leader>gl", function()
--  LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
--end, { desc = "Lazygit Log" })
--
--vim.keymap.set("n", "<leader>gL", function()
--  LazyVim.lazygit({ args = { "log" } })
--end, { desc = "Lazygit Log (cwd)" })

-- Add undo break-points
-- vim.keymap.set("i", ",", ",<c-g>u")
-- vim.keymap.set("i", ".", ".<c-g>u")
-- vim.keymap.set("i", ";", ";<c-g>u")

-- save file
-- vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- commenting
-- vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
-- vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- new file
-- vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
