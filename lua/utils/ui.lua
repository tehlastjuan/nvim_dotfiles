---@class util.ui
M = {}

M.icons = require("icons")

-- from config/init.lua
---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if M.icons.kind_filter == false then
    return
  end
  if M.icons.kind_filter[ft] == false then
    return
  end
  if type(M.icons.kind_filter[ft]) == "table" then
    ---@diagnostic disable-next-line: return-type-mismatch
    return M.icons.kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(M.icons.kind_filter) == "table" and type(M.icons.kind_filter.default) == "table" and M.icons.kind_filter.default or nil
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

return M
