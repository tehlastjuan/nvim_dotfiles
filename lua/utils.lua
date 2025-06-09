local icons = require("icons")

local M = {}

---@param msg string
function M.print_msg(msg)
	print(msg)
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
	if M.is_loaded(name) then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean, buf?:number}
---@return string
function M.get(opts)
	opts = opts or {}
	local buf = opts.buf or vim.api.nvim_get_current_buf()
	local ret = M.cache[buf]
	if not ret then
		local roots = M.detect({ all = false, buf = buf })
		ret = roots[1] and roots[1].paths[1] or vim.uv.cwd()
		M.cache[buf] = ret
	end

  return ret or ""
end

function M.git_root()
	local root = M.get()
	local git_root = vim.fs.find(".git", { path = root, upward = true })[1]
	local ret = git_root and vim.fn.fnamemodify(git_root, ":h") or root
	return ret
end

function M.config_files()
	return vim.fn.stdpath("config")
end


function M.bufpath(buf)
  return M.realpath(vim.api.nvim_buf_get_name(assert(buf)))
end

function M.cwd()
  return M.realpath(vim.uv.cwd()) or ""
end

function M.realpath(path)
  if path == "" or path == nil then
    return nil
  end
  path = vim.uv.fs_realpath(path) or path
  return vim.fs.normalize(path)
end

--- @param filetype string
--- @return {}
function M.fetch_ft_windows(filetype)
	local wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, v)
		local file_type = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(v) })
		return vim.api.nvim_win_get_config(v).relative ~= "" and file_type == filetype
	end)

	return wins
end

--- @param filetype string
function M.close_ft_windows(filetype)
	local wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, v)
		local file_type = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(v) })
		return vim.api.nvim_win_get_config(v).relative == ""
			and v ~= vim.api.nvim_get_current_win()
			and file_type == filetype
	end)

	for _, w in ipairs(wins) do
		pcall(vim.api.nvim_win_close, w, false)
	end
end

---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if icons.kind_filter == false then
    return
  end
  if icons.kind_filter[ft] == false then
    return
  end
  if type(icons.kind_filter[ft]) == "table" then
    ---@diagnostic disable-next-line: return-type-mismatch
    return icons.kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(icons.kind_filter) == "table" and type(icons.kind_filter.default) == "table" and icons.kind_filter.default or nil
end

return M
