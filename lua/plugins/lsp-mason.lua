local icons = require("icons").icons
--print(vim.inspect(icons))

return {

  -- cmdline tools and lsp servers
  -- {
  --   "williamboman/mason.nvim",
  --   cmd = "Mason",
  --   keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  --   build = ":MasonUpdate",
  --   opts_extend = { "ensure_installed" },
  --   opts = {
  --     ensure_installed = {
  --       -- "clang-format",
  --       -- "shellcheck",
  --       "shfmt",
  --       "stylua",
  --       -- "tailwindcss-language-server",
  --       -- "typescript-language-server",
  --     },
  --   },
  --   ---@param opts MasonSettings | {ensure_installed: string[]}
  --   config = function(_, opts)
  --     require("mason").setup(opts)
  --     local mr = require("mason-registry")
  --     mr:on("package:install:success", function()
  --       vim.defer_fn(function()
  --         -- trigger FileType event to possibly load this newly installed LSP server
  --         require("lazy.core.handler.event").trigger({
  --           event = "FileType",
  --           buf = vim.api.nvim_get_current_buf(),
  --         })
  --       end, 100)
  --     end)
  --
  --     mr.refresh(function()
  --       for _, tool in ipairs(opts.ensure_installed) do
  --         local p = mr.get_package(tool)
  --         if not p:is_installed() then
  --           p:install()
  --         end
  --       end
  --     end)
  --   end,
  -- },

  {
    "mason-org/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- import mason
      local mason = require("mason")
      -- import mason-lspconfig
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")
      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "",
            package_pending = "➜",
            package_uninstalled = "",
          },
        },
      })

      mason_lspconfig.setup({
        -- List of servers for mason to install
        ensure_installed = {
          --"astro",
          --"vtsls",
          --"html",
          --"eslint",
          --"cssls",
          --"lua_ls",
          --"graphql",
          --"emmet_ls",
          --"ruff",
          --"gopls",
          --"harper_ls",
          --"jsonls",
          --"ruby_lsp",
          --"yamlls",
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
        automatic_enable = false, -- removes multiple lsp servers
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "stylua",
          "shfmt",
          --"biome", -- JS, TS, TSX and JSON formatter, linter, and LSP
          --"prettier", -- prettier formatter
          --"ruff", -- python lsp, linter, and formatter
          --"mypy", -- python type checker
          --"gofumpt", -- go linters 👇
          --"goimports",
          --"golines",
          --"postgrestools",
          --"revive", -- go linters end,
          --"rubyfmt",
          --"rubocop", --  ruby linter and formatter
          --"sqruff",
          --"erb-lint", -- ruby end
          --"yamllint", -- yaml
          --"yq", -- yaml formatter
        },
      })
    end,
  },

}
