local utils = require("utils")

-- Source current config
vim.keymap.set("n", "<leader>cs", function()
	vim.cmd(":source " .. utils.config_files() .. "/init.lua")
end, { desc = "Source current config" })

----- windows

-- window management
-- vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
-- vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
-- vim.keymap.set("n", "<leader>wj", "<C-W>s", { desc = "Split window below", remap = true })
-- vim.keymap.set("n", "<leader>wl", "<C-W>v", { desc = "Split window right", remap = true })

-- move to window w/ <ctrl> + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- resize windows w/ <ctrl> + arrow keys
vim.keymap.set({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

------- window debug

-- stylua: ignore
vim.keymap.set("n", "<leader>wx", function() print(vim.inspect(vim.api.nvim_get_current_win())) end, { desc = "Get current window" })

-- stylua: ignore
vim.keymap.set("n", "<leader>wy", function() print(vim.inspect(vim.api.nvim_list_bufs())) end, { desc = "List buffers" })

vim.keymap.set("n", "<leader>wz", function()
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		print("win:" .. w .. "\n" .. vim.inspect(vim.api.nvim_win_get_config(w)))
		local file_type = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(w) })
		print("filetype:" .. vim.inspect(file_type))
	end
end, { desc = "List windows" })

-----  tabs

-- vim.keymap.set("n", "<C-s-,>", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
-- vim.keymap.set("n", "<C-s-.>", "<cmd>tabnext<cr>", { desc = "Next tab" })

------ buffers

-- buffer nav
vim.keymap.set("n", "<C-,>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<C-.>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Buffer Delete" })

------ text navigation

-- Keeping the cursor centered.
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll downwards" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll upwards" })
-- vim.keymap.set("n", "n", "nzzzv", { desc = "Next result" })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous result" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev result" })

-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- remap for dealing with word wrap and adding jumps to the jumplist.
-- vim.keymap.set("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
-- vim.keymap.set("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

----- text editing
-- https://stackoverflow.com/questions/3249275/multiple-commands-on-same-line

-- power-escape
local power_esc = function()
	local ok, trouble = pcall(function() return require("trouble") end)
  if ok and trouble.is_open() then
    trouble.close()
  end
	vim.cmd("noh")
	print("")
	return "<esc>"
end

-- clear search
-- stylua: ignore
vim.keymap.set("n", "<esc>", function() power_esc() end, { desc = "Escape and clear hlsearch" })
-- vim.keymap.set("n", "<esc>", ':noh<cr>:lua print("")<esc>', { silent = true, desc = "Escape and clear hlsearch" })
vim.keymap.set({ "n", "v" }, "<leader>ch", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- clear search, diff update and redraw, taken from runtime/lua/_editor.lua
vim.keymap.set(
	"n",
	"<leader>cr",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

-- handy mode
vim.keymap.set("i", "jk", "<esc>", { desc = "ESC" })
vim.keymap.set("i", "kj", "<esc>", { desc = "ESC" })

-- indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move Lines
vim.keymap.set("n", "<c-s-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<c-s-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<c-s-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<c-s-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<c-s-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<c-s-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- macros
vim.keymap.set("n", "<C-q>", "q")

-- close all buffers and quit
vim.keymap.set({ "n", "v" }, "<leader>qq", "<cmd>qa<cr>", { silent = true, desc = "quit" })

-- show highlights under cursor
vim.keymap.set({ "n", "v" }, "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set({ "n", "v" }, "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

----- nops

vim.keymap.set("n", "q", "<nop>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({ "n", "i", "x", "v", "o" }, "<Up>", "<nop>", { desc = "NOP" })
vim.keymap.set({ "n", "i", "x", "v", "o" }, "<Left>", "<nop>", { desc = "NOP" })
vim.keymap.set({ "n", "i", "x", "v", "o" }, "<Right>", "<nop>", { desc = "NOP" })
vim.keymap.set({ "n", "i", "x", "v", "o" }, "<Down>", "<nop>", { desc = "NOP" })

-- vim.keymap.del("n", "grn") -- mapped Normal mode to |vim.lsp.buf.rename()|
-- vim.keymap.del("n", "gra") -- mapped Normal and Visual mode to |vim.lsp.buf.code_action()|
-- vim.keymap.del("n", "grr") -- mapped Normal mode to |vim.lsp.buf.references()|
-- vim.keymap.del("n", "gri") -- mapped Normal mode to |vim.lsp.buf.implementation()|
-- vim.keymap.del("n", "gO") -- mapped in Normal mode to |vim.lsp.buf.document_symbol()|
-- vim.keymap.del("i", "<C-s>") -- mapped in Insert mode to |vim.lsp.buf.signature_help()|

----- plugins

-- Terminal navigation
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])

-- plugin manager
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true, desc = "Lazy" })

-- stylua: ignore
-- vim.keymap.set("n", "<leader>y", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end)

-- Opens a scratch buffer after command
-- https://yobibyte.github.io/vim.html
vim.keymap.set("n", "<leader>sb", function()
	vim.ui.input({}, function(c)
		if c and c ~= "" then
			vim.cmd("noswapfile vnew")
			vim.bo.buftype = "nofile"
			vim.bo.bufhidden = "wipe"
			vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
		end
	end)
end, { desc = "Create Scratch Buffer" })

--vim.keymap.set("n", "<leader>e", function()
--	local bufname = vim.api.nvim_buf_get_name(0)
--	local path = vim.fn.fnamemodify(bufname, ":p")
--
--	-- Noop if the buffer isn't valid.
--	if path and vim.uv.fs_stat(path) then
--		require("lir").float.toggle(path)
--	end
--end, { desc = "File explorer" })

-- Trouble
-- vim.keymap.set("n", "<leader>;", function()
-- 	--vim.cmd('Telescope buffers sort_mru=true sort_lastused=true')
-- 	--require("telescope.builtin").buffers()
--
-- 	vim.cmd(":enew | !ls")
-- 	local wins = utils.fetch_ft_windows("")
-- 	local buf = vim.api.nvim_win_get_buf(wins[1])
-- 	print(vim.inspect(buf))
-- 	require("trouble.sources.telescope").open(buf)
-- 	--vim.defer_fn(function()
-- 	--  require("trouble.sources.telescope").open(buf)
-- 	--end, 50)
--
-- 	--require("trouble").open("telescope_files")
-- 	--require("trouble.sources.telescope").open(buf)
-- end, { desc = "Switch Buffer (Trouble)" })
