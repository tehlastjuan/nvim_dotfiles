return {

  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        style_preset = {
          require("bufferline").style_preset.no_italic,
          -- require("bufferline").style_preset.no_bold,
        },
      },
    },
  },

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

  -- {
  --   "lervag/vimtex",
  --   -- opt = true,
  --   config = function()
  --     vim.g.vimtex_view_method = "zathura"
  --     vim.g.vimtex_quickfix_mode = 0
  --     vim.g.vimtex_view_general_viewer = "zathura"
  --     vim.g.vimtex_compiler_latexmk_engines = {
  --       _ = "-lualatex",
  --     }
  --     vim.g.tex_comment_nospell = 1
  --     vim.g.vimtex_compiler_progname = "latexrun"
  --     vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
  --     -- vim.g.vimtex_view_general_options_latexmk = '--unique'
  --   end,
  --   ft = "tex",
  -- },

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
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            AARRGGBB = false, -- 0xAARRGGBB hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
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
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        -- Normal = { link = "CursorColumn" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "Normal" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 65,
      open_mapping = [[<c-/>]],
      terminal_mappings = true,
      shade_terminals = true,
      -- shading_factor = 0,
      direction = "vertical",
      close_on_exit = true,
      -- float_opts = {
      -- border = "single",
      -- highlights = { border = "Normal", background = "Normal" },
      -- },
    },
  },

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     import = "lazyvim.plugins.extras.editor.telescope",
  --     enabled = function()
  --       return LazyVim.pick.want() == "telescope"
  --     end,
  --   },
  --   opts = function()
  --     return {
  --       defaults = {
  --         sorting_strategy = "ascending",
  --         create_layout = function(picker)
  --           local Layout = require("telescope.pickers.layout")
  --
  --           local config = {
  --             preview = {
  --               win = 1000,
  --               split = "right",
  --               -- width = 0.5,
  --               style = "minimal",
  --             },
  --             results = {
  --               split = "below",
  --               height = 10,
  --               style = "minimal",
  --             },
  --             prompt = {
  --               split = "above",
  --               height = 1,
  --               style = "minimal",
  --             },
  --           }
  --
  --           local function create_window(enter, opts)
  --             local bufnr = vim.api.nvim_create_buf(false, true)
  --             local winid = vim.api.nvim_open_win(bufnr, enter, opts)
  --             vim.wo[winid].winhighlight = "Normal:Normal"
  --
  --             return Layout.Window({
  --               bufnr = bufnr,
  --               winid = winid,
  --             })
  --           end
  --           local function destroy_window(window)
  --             if window then
  --               if vim.api.nvim_win_is_valid(window.winid) then
  --                 vim.api.nvim_win_close(window.winid, true)
  --               end
  --               if vim.api.nvim_buf_is_valid(window.bufnr) then
  --                 vim.api.nvim_buf_delete(window.bufnr, { force = true })
  --               end
  --             end
  --           end
  --
  --           local layout = Layout({
  --             picker = picker,
  --             mount = function(self)
  --               self.preview = create_window(false, config.preview)
  --               config.results["win"] = self.preview.winid
  --               self.results = create_window(false, config.results)
  --               config.prompt["win"] = self.results.winid
  --               self.prompt = create_window(true, config.prompt)
  --             end,
  --             unmount = function(self)
  --               destroy_window(self.results)
  --               destroy_window(self.preview)
  --               destroy_window(self.prompt)
  --             end,
  --             update = function(self) end,
  --           })
  --
  --           return layout
  --         end,
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   custom_theme = function()
  --     local themes = require("telescope.themes")
  --
  --     function themes.get_custom(opts)
  --       opts = opts or {}
  --
  --       local theme_opts = {
  --         theme = "custom",
  --
  --         sorting_strategy = "descending",
  --         layout_strategy = "vertical",
  --
  --         results_title = false,
  --         prompt_title = false,
  --         dynamic_preview_title = false,
  --
  --         layout_config = {
  --           anchor = "S",
  --           width = 0.8,
  --           height = 0.67,
  --           preview_cutoff = 1,
  --           preview_height = 25,
  --           prompt_position = "bottom",
  --           -- mirror = true,
  --         },
  --
  --         -- resolve.resolve_width()
  --         -- border = true,
  --         -- # ivy
  --         -- borderchars = {
  --         -- 	prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
  --         -- 	results = { " " },
  --         -- 	preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  --         -- },
  --         -- # ivy-alt
  --         -- borderchars = {
  --         -- 	prompt = { " ", " ", "─", " ", " ", " ", "─", "─" },
  --         -- 	results = { "─", " ", " ", " ", "─", "─", " ", " " },
  --         -- 	preview = { "─", " ", "─", "│", "┬", "─", "─", "╰" },
  --         -- },
  --         -- # cursor
  --         borderchars = {
  --           prompt = { " ", "│", "─", "│", "│", "│", "╯", "╰" },
  --           -- prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
  --           results = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
  --           -- results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
  --           preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  --         },
  --       }
  --
  --       return vim.tbl_deep_extend("force", theme_opts, opts)
  --     end
  --
  --     return themes
  --   end,
  -- },

  -- clisp
  -- {
  -- 	"neovim/nvim-lspconfig",
  --    config = function()
  -- 		local lspconfig = require("lspconfig")
  --
  -- 		-- Check if the config is already defined (useful when reloading this file)
  -- 		if not lspconfig.configs.cl_lsp then
  -- 			lspconfig.configs.cl_lsp = {
  -- 				default_config = {
  -- 					cmd = { vim.env.HOME .. "~/.roswell/bin/cl-lsp" },
  -- 					filetypes = { "lisp" },
  -- 					root_dir = lspconfig.util.find_git_ancestor,
  -- 					settings = {},
  -- 				},
  -- 			}
  -- 		end
  -- 	end,
  -- },

  -- {
  --   "monkoose/nvlime",
  --   dependencies = {
  --     "monkoose/parsley",
  --     "adolenc/cl-neovim",
  --     "gpanders/nvim-parinfer",
  --     {
  --       "nvim-treesitter/nvim-treesitter",
  --       opts = function(_, opts)
  --         if type(opts.ensure_installed) == "table" then
  --           vim.list_extend(opts.ensure_installed, { "commonlisp" })
  --         end
  --       end,
  --     },
  --   },
  --   cmp_enabled = function()
  --     vim.g.nvlime_config.cmp.enabled = true
  --   end,
  --   config = function()
  --     require("cmp").setup.filetype({ "lisp" }, {
  --       sources = {
  --         { name = "nvim_lsp" },
  --         { name = "path" },
  --         { name = "buffer" },
  --         { name = "nvlime" },
  --       },
  --     })
  --   end,
  -- },

  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
  },

  -- prolog
  -- {
  -- 	"neovim/nvim-lspconfig",
  -- 	dependencies = {
  -- 		"jamesnvc/lsp_server",
  -- 		-- "hargettp/prolog_lsp"
  -- 	},
  -- 	config = function()
  -- 		require("lspconfig").prolog_ls.setup({})
  -- 	end,
  -- },

  -- java
  -- {
  --   "nvim-java/nvim-java",
  --   dependencies = {
  --     "nvim-java/lua-async-await",
  --     "nvim-java/nvim-java-refactor",
  --     "nvim-java/nvim-java-core",
  --     "nvim-java/nvim-java-test",
  --     "nvim-java/nvim-java-dap",
  --     "MunifTanjim/nui.nvim",
  --     "neovim/nvim-lspconfig",
  --     "mfussenegger/nvim-dap",
  --     {
  --       "williamboman/mason.nvim",
  --       opts = {
  --         registries = {
  --           "github:nvim-java/mason-registry",
  --           "github:mason-org/mason-registry",
  --         },
  --       },
  --     },
  --   },
  --   init = function()
  --     require("java").setup()
  --     require("lspconfig").jdtls.setup({})
  --   end,
  -- },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
      =================     ===============     ===============   ========  ========
      \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
      ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
      || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
      ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
      || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
      ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
      || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
      ||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
      ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
      ||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
      ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
      ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
      ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
      ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
      ||.=='    _-'                                                     `' |  /==.||
      =='    _-'                        N E O V I M                         \/   `==
      \   _-'                                                                `-_   /
       `''                                                                      ``'
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
        dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
        dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
        dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
        dashboard.button("c", " " .. " Config",          "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function() end,
  },
}
