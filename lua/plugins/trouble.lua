return {

  -- diagnostics panel
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      auto_close = true, -- auto close when there are no items
      follow = true, -- Follow the current item
      ---@type table<string, trouble.Mode>
      modes = {
        diagnostics = {
          auto_close = true, -- auto close when there are no items
          auto_open = false, -- auto open when there are items
          auto_preview = false, -- automatically open preview when on an item
          auto_refresh = true, -- auto refresh when open
          auto_jump = false, -- auto jump to the item when there's only one
          focus = false, -- Focus the window when opened
          restore = false, -- restores the last location in the list when opening
          follow = true, -- Follow the current item
          indent_guides = true, -- show indent guides
          win = {
            type = "split",
            relative = "editor",
            position = "bottom",
            size = { height = 6 },
          },
          sort = { "severity", "pos" },
          filter = { buf = 0 }, -- filter diagnostics to the current buffer
        },
        symbols = {
          auto_close = false, -- auto close when there are no items
          auto_open = false, -- auto open when there are items
          auto_preview = false, -- automatically open preview when on an item
          auto_refresh = true, -- auto refresh when open
          auto_jump = false, -- auto jump to the item when there's only one
          focus = false, -- Focus the window when opened
          restore = true, -- restores the last location in the list when opening
          follow = true, -- Follow the current item
          indent_guides = true, -- show indent guides
          pinned = true,
          win = {
            type = "split",
            relative = "editor",
            position = "left",
            size = 40,
          },
        },
        lsp_document_symbols = {
          auto_close = false, -- auto close when there are no items
          auto_open = false, -- auto open when there are items
          auto_preview = true, -- automatically open preview when on an item
          auto_refresh = true, -- auto refresh when open
          auto_jump = false, -- auto jump to the item when there's only one
          focus = true, -- Focus the window when opened
          restore = false, -- restores the last location in the list when opening
          follow = true, -- Follow the current item
          indent_guides = true, -- show indent guides
          pinned = true,
          win = {
            fixed = true,
            type = "split",
            relative = "editor",
            position = "left",
            size = 40,
          },
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            -- title = "Preview",
            -- title_pos = "center",
            position = { 2, 46 },
            size = { width = 90, height = 25 },
            zindex = 200,
          },
        },
        -- cascade = {
        --   mode = "diagnostics", -- inherit from diagnostics mode
        --   filter = function(items)
        --     local severity = vim.diagnostic.severity.HINT
        --     for _, item in ipairs(items) do
        --       severity = math.min(severity, item.severity)
        --     end
        --     return vim.tbl_filter(function(item)
        --       return item.severity == severity
        --     end, items)
        --   end,
        -- },
      },
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xS", "<cmd>Trouble lsp_document_symbols toggle focus=false<cr>",
        desc = "LSP references/definitions/... (Trouble)", },
      -- { "<leader>xS", "<cmd>Trouble lsp toggle focus=false win.position=left<cr>",
      --   desc = "LSP references/definitions/... (Trouble)", },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

}
