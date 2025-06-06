return {

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = function()
      LazyVim.toggle.map("<leader>ug", {
        name = "Indention Guides",
        get = function()
          return require("ibl.config").get_config(0).enabled
        end,
        set = function(state)
          require("ibl").setup_buffer(0, { enabled = state })
        end,
      })

      return {
      indent = {
        char = "┆",
        tab_char = "╎",
        smart_indent_cap = false,
      },
      whitespace = {
        remove_blankline_trail = true,
        highlight = {
          "Function",
        },
      },
      scope = {
        enabled = true,
        char = "│",
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          'alpha',
          'checkhealth',
          'dashboard',
          'git',
          'gitcommit',
          'help',
          'lazy',
          'lazyterm',
          'lspinfo',
          'man',
          'mason',
          'neo-tree',
          'notify',
          'Outline',
          'TelescopePrompt',
          'TelescopeResults',
          'terminal',
          'toggleterm',
          'Trouble',
        },
      },
    }
    end,
    main = "ibl",
  },

}
