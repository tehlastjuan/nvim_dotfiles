return {

	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "ansible-lint" } },
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "ansiblels" },
		},
	},

	--local ensure_installed = vim.list_extend(ansiblels, {})

	{
		"mfussenegger/nvim-ansible",
		ft = {},
		keys = {
			{
				"<leader>ta",
				function()
					require("ansible").run()
				end,
				desc = "Ansible Run Playbook/Role",
				silent = true,
			},
		},
	},
}
