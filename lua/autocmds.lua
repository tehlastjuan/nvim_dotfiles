local function augroup(name)
	return vim.api.nvim_create_augroup("tehlastjuan_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Resize splits if window got resized.
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Go to last loc when opening a buffer.
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
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

-- Close some filetypes with <q>.
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q_and_esc"),
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
	--callback = function(args)
	--  vim.bo[args.buf].buflisted = false
	--  vim.schedule(function()
	--    vim.keymap.set("n", "q", function()
	--      vim.cmd("close")
	--      pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
	--    end, {
	--      buffer = args.buf,
	--      silent = true,
	--      desc = "Quit buffer",
	--    })
	--  end)
	--end,
})

-- make it easier to close man-files when opened inline
--vim.api.nvim_create_autocmd("FileType", {
--  group = augroup("man_unlisted"),
--  pattern = { "man" },
--  callback = function(args)
--    vim.bo[args.buf].buflisted = false
--  end,
--})

-- close some filetypes with <q>
--vim.api.nvim_create_autocmd("FileType", {
--  group = augroup("close_man_with_q"),
--  pattern = { "man" },
--  callback = function(args)
--    vim.keymap.set("n", "q", ":q<cr>", {
--      buffer = args.buf,
--      silent = true,
--      desc = "Quit buffer",
--    })
--  end,
--})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = false
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(args)
		if args.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(args.match) or args.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.filetype.add({
	pattern = {
		[".*"] = {
			function(path, buf)
				return vim.bo[buf]
						and vim.bo[buf].filetype ~= "bigfile"
						and path
						and vim.fn.getfsize(path) > vim.g.bigfile_size
						and "bigfile"
					or nil
			end,
		},
	},
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("bigfile"),
	pattern = "bigfile",
	callback = function(ev)
		vim.b.minianimate_disable = true
		vim.schedule(function()
			vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
		end)
	end,
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup("help_window_right"),
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})

-- Write to ShaDa when deleting/wiping out buffers
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
	group = augroup("wshada_on_buf_delete"),
	desc = "Write to ShaDa when deleting/wiping out buffers",
	command = "wshada",
})

-- list available keymaps
vim.api.nvim_create_user_command("UnmappedKeys", function()
	local has_mapping = function(mode, lhs)
		local mappings = vim.api.nvim_get_keymap(mode)
		for _, mapping in ipairs(mappings) do
			if mapping.lhs == true then
				return true
			end
		end
		return false
	end

	for i = 0, 255 do
		local char = string.char(i)
		if not has_mapping("n", char) then
			print("Unmapped key: " .. char)
		end
	end
end, { desc = "Get unmapped key list" })
