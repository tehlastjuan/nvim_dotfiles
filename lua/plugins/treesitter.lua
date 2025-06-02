return {

  -- Highlight, edit, and navigate code.
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          -- Avoid the sticky context from growing a lot.
          max_lines = 3,
          -- Match the context lines to the source code.
          multiline_threshold = 1,
          -- Disable it when the window is too small.
          min_window_height = 20,
        },
        keys = {
          {
            '[c',
            function()
              -- Jump to previous change when in diffview.
              if vim.wo.diff then
                return '[c'
              else
                vim.schedule(function()
                    require('treesitter-context').go_to_context()
                end)
                return '<Ignore>'
              end
            end,
            desc = 'Jump to upper context',
            expr = true,
          },
        },
      },
    },
    version = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        "bash",
        "c",
				"css",
        "diff",
				"dockerfile",
        "gitcommit",
				"go",
        "graphql",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "lua",
        "luap",
        "luadoc",
        "markdown",
        "markdown_inline",
				"php",
        "printf",
        "python",
        "query",
        "rasi",
        "regex",
				"rust",
				"scss",
				"sql",
        "toml",
				"tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "xml",
				"yaml",
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<cr>',
          node_incremental = '<cr>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      indent = {
        enable = true,
        -- Treesitter unindents Yaml lists for some reason.
        disable = { 'yaml' },
      },
    },
    config = function(_, opts)
      local toggle_inc_selection_group =
        vim.api.nvim_create_augroup('mariasolos/toggle_inc_selection', { clear = true })
      vim.api.nvim_create_autocmd('CmdwinEnter', {
        desc = 'Disable incremental selection when entering the cmdline window',
        group = toggle_inc_selection_group,
        command = 'TSBufDisable incremental_selection',
      })
      vim.api.nvim_create_autocmd('CmdwinLeave', {
        desc = 'Enable incremental selection when leaving the cmdline window',
        group = toggle_inc_selection_group,
        command = 'TSBufEnable incremental_selection',
      })

      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = "BufWritePre",
    opts = {},
  },

}
