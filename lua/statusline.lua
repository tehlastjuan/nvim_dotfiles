local icons = require("icons")

local M = {}

-- Don't show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

--- Keeps track of the highlight groups already created.
---@type table<string, boolean>
local statusline_hls = {}

---@param hl string
---@return string
function M.get_or_create_hl(hl)
	local hl_name = "Statusline" .. hl

	if not statusline_hls[hl] then
		-- If not in the cache, create the highlight group using the icon's foreground color
		-- and the statusline's background color.
		local bg_hl = vim.api.nvim_get_hl(0, { name = "StatusLine" })
		local fg_hl = vim.api.nvim_get_hl(0, { name = hl })
		vim.api.nvim_set_hl(0, hl_name, { bg = ("#%06x"):format(bg_hl.bg), fg = ("#%06x"):format(fg_hl.fg) })
		statusline_hls[hl] = true
	end

	return hl_name
end

--- Current mode.
---@return string
function M.mode_component()
	-- Note that: \19 = ^S and \22 = ^V.
	local mode_to_str = {
		["n"] = "NORMAL",
		["no"] = "OP-PENDING",
		["nov"] = "OP-PENDING",
		["noV"] = "OP-PENDING",
		["no\22"] = "OP-PENDING",
		["niI"] = "NORMAL",
		["niR"] = "NORMAL",
		["niV"] = "NORMAL",
		["nt"] = "NORMAL",
		["ntT"] = "NORMAL",
		["v"] = "VISUAL",
		["vs"] = "VISUAL",
		["V"] = "VISUAL",
		["Vs"] = "VISUAL",
		["\22"] = "VISUAL",
		["\22s"] = "VISUAL",
		["s"] = "SELECT",
		["S"] = "SELECT",
		["\19"] = "SELECT",
		["i"] = "INSERT",
		["ic"] = "INSERT",
		["ix"] = "INSERT",
		["R"] = "REPLACE",
		["Rc"] = "REPLACE",
		["Rx"] = "REPLACE",
		["Rv"] = "VIRT REPLACE",
		["Rvc"] = "VIRT REPLACE",
		["Rvx"] = "VIRT REPLACE",
		["c"] = "COMMAND",
		["cv"] = "VIM EX",
		["ce"] = "EX",
		["r"] = "PROMPT",
		["rm"] = "MORE",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		["t"] = "TERMINAL",
	}

	-- Get the respective string to display.
	local mode = mode_to_str[vim.api.nvim_get_mode().mode] or "UNKNOWN"

	-- Set the highlight group.
	local hl = "Other"
	if mode:find("NORMAL") then
		hl = "Normal"
	elseif mode:find("PENDING") then
		hl = "Pending"
	elseif mode:find("VISUAL") then
		hl = "Visual"
	elseif mode:find("INSERT") or mode:find("SELECT") then
		hl = "Insert"
	elseif mode:find("COMMAND") or mode:find("TERMINAL") or mode:find("EX") then
		hl = "Command"
	end

	-- Construct the bubble-like component.
	return table.concat({
		string.format("%%#StatuslineMode%s#  %%##", hl),
		string.format("%%#StatuslineSep%s#%%##", hl),
	})
end

--- Hostname.
---@return string
function M.hostname_component()
  -- local fd_hostname = assert(io.open("/etc/hostname"), "r")
  -- local hostname = fd_hostname:read("*l")
  -- fd_hostname:close()

  local hostname = ""
	local fh,_ = assert(io.popen("uname -n 2>/dev/null", "r"))
  if fh then
    hostname = fh:read()
  end

  -- return string.format(" @%s", hostname)
	return string.format("%%#StatuslineHostname# @%s", hostname)
end

--- Git status (if any).
---@return string
function M.git_component()
	local head = vim.b.gitsigns_head
	if not head or head == "" then
		return ""
	end

  -- return string.format(" %s%s ", icons.misc.git, head)
	return string.format("%%#StatuslineBranch# *%s ", head)
end

--- Filename (if any).
---@return string
function M.filename_component()
	local isNarrow = vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3)
	local path = vim.fs.normalize(vim.fn.expand(isNarrow and "%:r" or "%:p") --[[@as string]])

	-- If the window gets too narrow, shorten the path and drop the prefix.
	-- No special styling for diff views.
	if isNarrow or vim.startswith(path, "diffview") then
		return string.format("%%#StatuslineRegular#%s", path)
	end

	-- Replace slashes by arrows.
	local separator = "%#StatuslineDir#/" -- └─    󰅂 󰿟 

	-- For some special folders, add a prefix instead of the full path
	-- (making sure to pick the longest prefix).
	---@type table<string, string>
	local special_dirs = {
		XDG_CONFIG_HOME = vim.env.XDG_CONFIG_HOME,
		HOME = vim.env.HOME,
	}

	local prefix, prefix_path = "", ""
	for dir_name, dir_path in pairs(special_dirs) do
		if vim.startswith(path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path then
			prefix, prefix_path = dir_name, dir_path
		end
	end
	if prefix ~= "" then
		path = path:gsub("^" .. prefix_path, "")
		prefix = string.format("%%#StatuslineDir#%s%s", prefix, separator)
	end

	-- Remove leading slash.
	path = path:gsub("^/", "")

	return table.concat({
		"",
		prefix,
		table.concat(
			vim.iter(vim.split(path, "/"))
				:map(function(segment)
					return string.format("%%#StatuslineRegular#%s", segment)
				end)
				:totable(),
			separator
		),
	})
end

--- The current debugging status (if any).
---@return string?
function M.dap_component()
	if not package.loaded["dap"] or require("dap").status() == "" then
		return nil
	end
	return string.format("%%#%s#%s %s", M.get_or_create_hl("Special"), icons.misc.bug, require("dap").status())
end

---@type table<string, string?>
local progress_status = {
	client = nil,
	kind = nil,
	title = nil,
}

vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("tehlastjuan/statusline", { clear = true }),
	desc = "Update LSP progress in statusline",
	pattern = { "begin", "end" },
	callback = function(args)
		-- This should in theory never happen, but I've seen weird errors.
		if not args.data then
			return
		end

		progress_status = {
			client = vim.lsp.get_client_by_id(args.data.client_id).name,
			kind = args.data.params.value.kind,
			title = args.data.params.value.title,
		}

		if progress_status.kind == "end" then
			progress_status.title = nil
			-- Wait a bit before clearing the status.
			vim.defer_fn(function()
				vim.cmd.redrawstatus()
			end, 3000)
		else
			vim.cmd.redrawstatus()
		end
	end,
})

--- The latest LSP progress message.
---@return string
function M.lsp_progress_component()
	if not progress_status.client or not progress_status.title then
		return ""
	end

	-- Avoid noisy messages while typing.
	if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
		return ""
	end

	return table.concat({
		string.format("%%#StatuslineSpinner#%s", icons.misc.spinner),
		string.format("%%#StatuslineItalic#%s  ", progress_status.client),
		--string.format("%%#StatuslineItalic#%s...", progress_status.title),
	})
end

local last_diagnostic_component = ""
--- Diagnostic counts in the current buffer.
---@return string
function M.diagnostics_component()
	-- Lazy uses diagnostic icons, but those aren't errors per se.
	if vim.bo.filetype == "lazy" then
		return ""
	end

	-- Use the last computed value if in insert mode.
	if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
		return last_diagnostic_component
	end

	local counts = vim.iter(vim.diagnostic.get(0)):fold({
		ERROR = 0,
		WARN = 0,
		HINT = 0,
		INFO = 0,
	}, function(acc, diagnostic)
		local severity = vim.diagnostic.severity[diagnostic.severity]
		acc[severity] = acc[severity] + 1
		return acc
	end)

	local parts = vim.iter(counts)
		:map(function(severity, count)
			if count == 0 then
				return nil
			end

			local severity_key = severity:sub(1, 1) .. severity:sub(2):lower()
			local hl = "Diagnostic" .. severity_key
			return string.format("%%#%s#%s%d", M.get_or_create_hl(hl), icons.diagnostics[severity], count)
		end)
		:totable()

	return table.concat(parts, " ")
end

--- File diff stats for the current buffer.
---@return string
function M.diff_component()
	local git = vim.b.gitsigns_status_dict
	if git ~= nil then
		local added = git.added
		local removed = git.removed
		local modified = git.changed
		local gs = ""

		if added ~= nil and added > 0 then
			gs = gs .. "%#StatuslineGitAdd# " .. icons.git.added .. added .. ""
		end
		if modified ~= nil and modified > 0 then
			gs = gs .. "%#StatuslineGitMod# " .. icons.git.modified .. modified .. ""
		end
		if removed ~= nil and removed > 0 then
			gs = gs .. "%#StatuslineGitRem# " .. icons.git.removed .. removed .. ""
		end

		return gs
	else
		return ""
	end
end

--- The file current status.
---@return string
function M.fileflags_component()
	return string.format(
		"%%#%s#%s",
		vim.api.nvim_get_option_value("modified", {}) and "StatuslineFileMod" or "StatuslineFileUnMod",
		icons.misc.fileModified
	)
end

--- The buffer's filetype.
---@return string
function M.filetype_component()
	local devicons = require("nvim-web-devicons")

	-- Special icons for some filetypes.
	local special_icons = {
		DiffviewFileHistory = { icons.misc.git, "Number" },
		DiffviewFiles = { icons.misc.git, "Number" },
		["ccc-ui"] = { icons.misc.palette, "Comment" },
		["dap-view"] = { icons.misc.bug, "Special" },
		["grug-far"] = { icons.misc.search, "Constant" },
		fzf = { icons.misc.terminal, "Special" },
		TelescopePrompt = { icons.misc.terminal, "Special" },
		gitcommit = { icons.misc.git, "Number" },
		gitrebase = { icons.misc.git, "Number" },
		lazy = { icons.kinds.Method, "Special" },
		lazyterm = { icons.misc.terminal, "Special" },
		minifiles = { icons.kinds.Folder, "Directory" },
		qf = { icons.misc.search, "Conditional" },
	}

	local filetype = vim.bo.filetype
	if filetype == "" then
		filetype = "[No Name]"
	end

	local icon, icon_hl
	if special_icons[filetype] then
		icon, icon_hl = unpack(special_icons[filetype])
	else
		local buf_name = vim.api.nvim_buf_get_name(0)
		local name, ext = vim.fn.fnamemodify(buf_name, ":t"), vim.fn.fnamemodify(buf_name, ":e")

		icon, icon_hl = devicons.get_icon(name, ext)
		if not icon then
			icon, icon_hl = devicons.get_icon_by_filetype(filetype, { default = true })
		end
	end
	icon_hl = M.get_or_create_hl(icon_hl)

	return string.format("%%#%s#%s %%#StatuslineBold#%s", icon_hl, icon, filetype)
end

--- File-content encoding for the current buffer.
---@return string
function M.encoding_component()
	local encoding = vim.opt.fileencoding:get()
	return encoding ~= "" and string.format("%%#StatuslineRegular#%s", encoding) or ""
end

--- The current line, total line count, and column position.
---@return string
function M.position_component()
	local line = vim.fn.line(".")
	local line_count = vim.api.nvim_buf_line_count(0)
	local col = vim.fn.virtcol(".")

	return table.concat({
		string.format("%%#StatuslineCols#%d", col),
		string.format("%%#StatuslineLines#.%d:", line),
		string.format("%%#StatuslineLines#%d", line_count),
	})
end

---@return boolean
function M.check_filetype()
	local ft_to_str = {
		"neo-tree",
		"help",
		"dashboard",
		"alpha",
		"starter",
		"trouble",
		"toggleterm",
		"lazyterm",
		"TelescopePrompt",
	}

	local filetype = vim.bo.filetype
	for _, value in ipairs(ft_to_str) do
		if filetype == value or filetype == "" then
			return true
		end
	end
	return false
end

--- Renders the statusline.
---@return string
function M.render()
	---@param components string[]
	---@param spaces integer
	---@return string
	local function concat_components(components, spaces)
		return vim.iter(components):skip(1):fold(components[1], function(acc, component)
			return #component > 0 and string.format("%s%s%s", acc, string.rep(" ", spaces), component) or acc
		end)
	end

	if M.check_filetype() then
		return "%#StatusLineNC#%="
		--return table.concat({ M.mode_component(), "%#StatusLineNC#%=" })
	end

	return table.concat({
		concat_components({
			M.mode_component(),
			M.hostname_component(),
			M.git_component(),
			M.filename_component(),
			M.dap_component(),
		}, 1),
		"%#StatusLine#%=",
		concat_components({
			M.lsp_progress_component(),
			M.diagnostics_component(),
			--M.diff_component(),
			M.fileflags_component(),
			M.filetype_component(),
			M.encoding_component(),
			M.position_component(),
		}, 2),
		" ",
	})
end

vim.o.statusline = "%!v:lua.require'statusline'.render()"

return M
