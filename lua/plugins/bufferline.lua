local icons = require("icons")

return {

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      -- Buffer navigation.
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close Other Buffers" },
      { "<leader>bn", "<cmd>BufferLinePick<cr>", desc = "Pick a buffer to open" },
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
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_tab_indicators = false,
        show_close_icon = false,
        color_icons = true,
        -- stylua: ignore
        --close_command = function(n) LazyVim.ui.bufremove(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) LazyVim.ui.bufremove(n) end,
        diagnostics_indicator = function(_, _, diag)
          local icons = icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
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
}
