--local icons = require("config").icons

local M = {}

function M.render_path(path)
  --local path = vim.fs.normalize(vim.fn.expand '%:p' --[[@as string]])

  -- No special styling for diff views.
  if vim.startswith(path, "diffview") then
    return string.format("%%#WinBar#%s", path)
  end

  -- Replace slashes by arrows.
  local separator = "%#WinBarSeparator# " --    󰅂 󰿟 

  local prefix, prefix_path = "", ""

  -- If the window gets too narrow, shorten the path and drop the prefix.
  if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
    path = vim.fn.pathshorten(path)
  else
    -- For some special folders, add a prefix instead of the full path
    -- (making sure to pick the longest prefix).
    ---@type table<string, string>
    local special_dirs = {
      XDG_CONFIG_HOME = vim.env.XDG_CONFIG_HOME,
      HOME = vim.env.HOME,
    }

    for dir_name, dir_path in pairs(special_dirs) do
      if vim.startswith(path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path then
        prefix, prefix_path = dir_name, dir_path
      end
    end
    if prefix ~= "" then
      path = path:gsub("^" .. prefix_path, "")
      prefix = string.format("%%#WinBarDir#%s%s", prefix, separator)
    end
  end

  -- Remove leading slash.
  path = path:gsub("^/", "")

  return table.concat({
    " ",
    prefix,
    table.concat(
      vim
        .iter(vim.split(path, "/"))
        :map(function(segment)
          return string.format("%%#WinBarNC#%s", segment)
        end)
        :totable(),
      separator
    ),
  })
end

return M
