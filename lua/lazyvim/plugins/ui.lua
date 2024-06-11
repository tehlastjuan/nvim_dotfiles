return {
  -- Better `vim.notify()`
  -- {
  --   "rcarriga/nvim-notify",
  --   keys = {
  --     {
  --       "<leader>un",
  --       function()
  --         require("notify").dismiss({ silent = true, pending = true })
  --       end,
  --       desc = "Dismiss All Notifications",
  --     },
  --   },
  --   opts = {
  --     stages = "static",
  --     timeout = 3000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.75)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.75)
  --     end,
  --     on_open = function(win)
  --       vim.api.nvim_win_set_config(win, { zindex = 100 })
  --     end,
  --   },
  --   init = function()
  --     -- when noice is not enabled, install notify on VeryLazy
  --     if not LazyVim.has("noice.nvim") then
  --       LazyVim.on_very_lazy(function()
  --         vim.notify = require("notify")
  --       end)
  --     end
  --   end,
  -- },

  -- This is what powers LazyVim's fancy-looking
  -- tabs, which include filetype icons and close buttons.
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      -- { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      -- { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    opts = {
      options = {
        -- stylua: ignore
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        enforce_regular_tabs = true,
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 17,
        separator_style = { "" }, -- slant | "slope" | "thick" | "thin" | { 'any', 'any' },
        indicator = {
          -- icon = "",
          style = "none",
        },
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_tab_indicators = false,
        show_close_icon = false,
        color_icons = true,
        close_command = function(n)
          LazyVim.ui.bufremove(n)
        end,
        right_mouse_command = function(n)
          LazyVim.ui.bufremove(n)
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,

        -- stylua: ignore
        -- stylua: ignore
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
						separator = "│",
          },
        },
      },
      highlights = {
        fill = {
          bg = "#1e222a",
        },
      },
    },

    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "onedark",
          component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "neo-tree" } },
        },
        sections = {
          lualine_a = {
            { "mode", icon = "", padding = 1 },
          },
          lualine_b = {
            { "branch", padding = { left = 2, right = 1 } },
          },
          lualine_c = {
            LazyVim.lualine.root_dir(),
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 4, file_status = true, padding = { left = 1, right = 2 } },
            -- { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = LazyVim.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = LazyVim.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = LazyVim.ui.fg("Debug"),
            },
            -- {
            --   require("lazy.status").updates,
            --   cond = require("lazy.status").has_updates,
            --   color = LazyVim.ui.fg("Special"),
            -- },
            { "encoding", padding = { left = 1, right = 0 } },
            { "fileformat", padding = { left = 1, right = 1 } },
            { "filetype", padding = { left = 1, right = 2 } },
          },
          lualine_z = {
            { "location", separator = "|", padding = { left = 2, right = 1 } },
            { "progress", padding = { left = 1, right = 2 } },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      if vim.g.trouble_lualine then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = symbols and symbols.has,
        })
      end

      return opts
    end,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
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
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },

  -- Displays a popup with possible key bindings of the command you started typing
  -- {
  --   "folke/which-key.nvim",
  --   opts = function(_, opts)
  --     if LazyVim.has("noice.nvim") then
  --       opts.defaults["<leader>sn"] = { name = "+noice" }
  --     end
  --   end,
  -- },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "goolord/alpha-nvim",
    optional = true,
    enabled = function()
      LazyVim.warn({
        "`dashboard.nvim` is now the default LazyVim starter plugin.",
        "",
        "To keep using `alpha.nvim`, please enable the `lazyvim.plugins.extras.ui.alpha` extra.",
        "Or to hide this message, remove the alpha spec from your config.",
      })
      return false
    end,
  },
}
