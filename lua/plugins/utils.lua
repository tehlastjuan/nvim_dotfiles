return {

  {
    "ray-x/web-tools.nvim",
    opts = {
      keymaps = {
        rename = nil, -- by default use same setup of lspconfig
        -- repeat_rename = ".", -- . to repeat
      },
      hurl = { -- hurl default
        show_headers = false, -- do not show http headers
        floating = false, -- use floating windows (need guihua.lua)
        json5 = false,
        formatters = { -- format the result by filetype
          json = { "jq" },
          html = { "prettier", "--parser", "html" },
        },
      },
    },
  },

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      return {
        require("colorizer").setup({
          filetypes = { "*" },
          user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = false, -- "Name" codes like Blue or blue
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            AARRGGBB = true, -- 0xAARRGGBB hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- Available modes for `mode`: foreground, background,  virtualtext
            mode = "background", -- Set the display mode.
            -- Available methods are false / true / "normal" / "lsp" / "both"
            -- True is same as normal
            tailwind = false, -- Enable tailwind colors
            -- parsers can contain values used in |user_default_options|
            sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
            virtualtext = "■",
            -- update color values even if buffer is not focused
            -- example use: cmp_menu, cmp_docs
            always_update = false,
          },
          -- all the sub-options of filetypes apply to buftypes
          buftypes = {},
        }),
      }
    end,
  },

  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      require('lazy').load { plugins = { 'markdown-preview.nvim' } }
      vim.fn['mkdp#util#install']()
    end,
    keys = {
      {
        '<leader>cp',
        ft = 'markdown',
        '<cmd>MarkdownPreviewToggle<cr>',
        desc = 'Markdown Preview',
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
    keys = {
      {
        "<leader>ct",
        ft = "typst",
        "<cmd>TypstPreview<cr>",
        desc = "Typst Preview",
      },
    },
  },

  {
    "lervag/vimtex",
    -- opt = true,
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_view_method = "zathura"
      --vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_view_general_viewer = "zathura"
      vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex", }
      vim.g.tex_comment_nospell = 1
      vim.g.vimtex_compiler_progname = "latexrun"
      --vim.g.vimtex_compiler_method = "latexrun"
      vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      -- vim.g.vimtex_view_general_options_latexmk = '--unique'
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtex" },
    },
    ft = "tex",
  },

}
