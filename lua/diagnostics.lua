local icons = require("icons")

-- Define the diagnostic signs.
for severity, icon in pairs(icons.diagnostics) do
	local hl = "DiagnosticSign" .. severity:sub(1, 1) .. severity:sub(2):lower()
	vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Diagnostic configuration.
---@type vim.diagnostic.Opts
vim.diagnostic.config({
	underline = false,
	virtual_text = false,
	virtual_lines = false,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
		},
	},
	update_in_insert = false,
	severity_sort = true,
	jump = { float = true },
	inlay_hints = { enabled = false },
	codelens = { enabled = false },
	document_highlight = { enabled = true },
	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},
})
