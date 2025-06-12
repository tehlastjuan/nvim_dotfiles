return {

	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				dockerfile = { "hadolint" },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				dockerls = {},
				docker_compose_language_service = {},
			},
		},
	},
}
