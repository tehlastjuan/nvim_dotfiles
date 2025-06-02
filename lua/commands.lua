-- LazyExtras access
vim.api.nvim_create_user_command("LazyExtras", function()
  require("lazyvim.util").extras.show()
end, { desc = "Manage LazyVim extras" })

-- List available keymaps
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


