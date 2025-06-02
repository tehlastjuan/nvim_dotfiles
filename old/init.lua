-- if you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua
package.loaded["lazyvim.config.options"] = true
vim.uv = vim.uv or vim.loop

local M = {}

---@param opts? LazyVimConfig
function M.setup(opts)
  require("lazyvim.config").setup(opts)
end

return M
