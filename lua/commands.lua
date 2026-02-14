-- list available keymaps
vim.api.nvim_create_user_command("UnmappedKeys", function()
	local has_mapping = function(mode, lhs)
		local mappings = vim.api.nvim_get_keymap(mode)
		for _, mapping in ipairs(mappings) do
			if mapping == lhs then
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


vim.api.nvim_create_user_command("AddToMasonRegistry", function(opts)
  local args = opts.fargs
  local mason = require("mason-lspconfig")
  mason.setup({
    ensure_installed = vim.list_extend(args, mason.get_available_servers() or {}),
  })
end, { desc = "Adds lsp server to mason's ensure_installed"})
