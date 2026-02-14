local function augroup(name)
	return vim.api.nvim_create_augroup("tehlastjuan_" .. name, { clear = true })
end

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
  desc = "Create dir on save if doesn't exist",
	callback = function(args)
		if args.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(args.match) or args.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("bigfile"),
  desc = "Disable features in big files",
	pattern = "bigfile",
	callback = function(args)
		vim.schedule(function()
			vim.bo[args.buf].syntax = vim.filetype.match({ buf = args.buf }) or ""
		end)
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
  desc = "Check and reload",
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Close some filetypes with <q>.
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q_and_esc"),
  desc = "Close with q and ESC",
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"man",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"trouble",
	},
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
		vim.keymap.set("n", "<esc>", "<cmd>quit<cr>", { buffer = args.buf })
	end,
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup("help_window_right"),
  desc = "Help splits on the right",
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

-- Highlight on yank.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
  desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("json_conceal"),
  desc = "Disable conceal on json files",
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Go to last loc when opening a buffer.
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
  desc = "Go to last location on buffer opening",
	callback = function(args)
		local exclude = { "gitcommit" }
		local buf = args.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- Resize splits if window got resized.
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
  desc = "Resize splits on window resize",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
  desc = "Wrap and check spelling on text files",
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = false
	end,
})

-- vim.filetype.add({
-- 	pattern = {
-- 		[".*"] = {
-- 			function(path, buf)
-- 				return vim.bo[buf]
-- 						and vim.bo[buf].filetype ~= "bigfile"
-- 						and path
-- 						and vim.fn.getfsize(path) > vim.g.bigfile_size
-- 						and "bigfile"
-- 					or nil
-- 			end,
-- 		},
-- 	},
-- })

-- Auto-folding w/ treesitter
vim.api.nvim_create_autocmd('FileType', {
  group = augroup("treesitter_folding"),
  desc = 'Enable Treesitter folding',
  callback = function(args)
    local bufnr = args.buf
    -- Enable Treesitter folding when not in huge files and when Treesitter
    -- is working.
    if vim.bo[bufnr].filetype ~= 'bigfile' and pcall(vim.treesitter.start, bufnr) then
      vim.api.nvim_buf_call(bufnr, function()
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.cmd.normal 'zx'
      end)
    end
  end,
})

-- Write to ShaDa when deleting/wiping out buffers
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
	group = augroup("wshada_on_buf_delete"),
	desc = "Write to ShaDa when deleting/wiping out buffers",
	command = "wshada",
})
