return {

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- https://www.reddit.com/r/neovim/comments/1fkprp5/how_to_properly_setup_lspconfig_for_toml_files/
				taplo = {
					cmd = { "taplo", "lsp", "stdio" },
					filetypes = { "toml" },
          root_markers = { "*.toml", ".git" },
					settings = {
						taplo = {
							configFile = { enabled = true },
              format = {
                enable = true,
              },
              schema = {
								enabled = true,
								catalogs = { "https://www.schemastore.org/api/json/catalog.json" },
								cache = {
									memoryExpiration = 60,
									diskExpiration = 600,
								},
							},
						},
					},
				},
			},
		},
	},
}
