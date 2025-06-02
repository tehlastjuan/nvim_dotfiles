local util_extras = require("util.extras")
local util_json = require("util.json")
local util_plugin = require("util.json")

-- Some extras need to be loaded before others
local prios = {
  ["plugins.extras.test.core"] = 1,
  ["plugins.extras.dap.core"] = 1,
  -- ["lazyvim.plugins.extras.ui.edgy"] = 2,
  ["plugins.extras.lang.typescript"] = 5,
  ["plugins.extras.coding.blink"] = 5,
  ["plugins.extras.formatting.prettier"] = 10,
  -- default priority is 50
  ["plugins.extras.editor.aerial"] = 100,
  ["plugins.extras.editor.outline"] = 100,
}

if vim.g.xtras_prios then
  prios = vim.tbl_deep_extend("force", prios, vim.g.xtras_prios or {})
end

---@type string[]
local extras = dedup(json.data.extras)

local version = vim.version()
local v = version.major .. "_" .. version.minor

local compat = { "0_9" }

util_extras.save_core()
if vim.tbl_contains(compat, v) then
  table.insert(extras, 1, "plugins.compat.nvim-" .. v)
end

table.sort(extras, function(a, b)
  local pa = prios[a] or 10
  local pb = prios[b] or 10
  if pa == pb then
    return a < b
  end
  return pa < pb
end)

---@param extra string
return vim.tbl_map(function(extra)
  return { import = extra }
end, extras)
