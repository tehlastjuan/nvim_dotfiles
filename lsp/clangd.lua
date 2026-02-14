-- Install with
-- mac: brew install llvm
-- Arch: pacman -S clang

---@type vim.lsp.Config
return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
	},
	filetypes = { "c", "cpp" },
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
	root_markers = {
		"Makefile",
		"configure.ac",
		"configure.in",
		"config.h.in",
		"meson.build",
		"meson_options.txt",
		"build.ninja",
		"compile_commands.json",
		"compile_flags.txt",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
}
