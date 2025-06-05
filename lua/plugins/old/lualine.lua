return {

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
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("config").icons
      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "onedark",
          component_separators = { left = "", right = "" },
          --section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter", "neo-tree" },
            --winbar = { "dashboard", "alpha", "starter", "neo-tree", "trouble", "help" },
          },
        },
        sections = {
          lualine_a = {
            { "mode", icon = "", padding = 1 },
          },
          lualine_b = {
            { "branch", padding = { left = 2, right = 1 } },
          },
          lualine_c = {
            --LazyVim.lualine.root_dir(),
            --{ function() return render_path(vim.fs.normalize(vim.fn.expand '%:p' --[[@as string]])) end, },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 4, file_status = true, padding = { left = 1, right = 2 } },
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
            { "encoding", padding = 1 },
            { "fileformat", icons_enabled = false, padding = 1 },
            { "filetype", padding = { left = 1, right = 2 } },
          },
          lualine_z = {
            {
              "location",
              separator = "",
              padding = { left = 1, right = 1 },
              --color = { fg = "#1e222a", bg = "#4dbdcb", gui = "bold" },
            },
            --{ "progress", padding = { left = 1, right = 2 } },
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
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
}
