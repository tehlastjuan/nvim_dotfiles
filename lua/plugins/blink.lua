return {

  -- Auto-completion:
  {
    'saghen/blink.cmp',
    dependencies = {
      'LuaSnip',
      "rafamadriz/friendly-snippets"
    },
    version ="*",
    event = 'InsertEnter',
    opts = {
      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-\\>'] = { 'hide', 'fallback' },
        ['<C-n>'] = { 'select_next', 'show' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<C-p>'] = { 'select_prev' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      completion = {
        list = {
          -- Insert items while navigating the completion list.
          selection = { preselect = false, auto_insert = true },
          max_items = 10,
        },
        documentation = { auto_show = true },
      },
      snippets = { preset = 'luasnip' },
      cmdline = {
        enabled = true,
        completion = {
          menu = { auto_show = true },
        },
      },
      sources = {
        -- Disable some sources in comments and strings.
        default = function()
          local sources = { 'lsp', 'path', 'snippets', 'buffer' }
          local ok, node = pcall(vim.treesitter.get_node)

          if ok and node then
            if not vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
              table.insert(sources, 'path')
            end
            if node:type() ~= 'string' then
              table.insert(sources, 'snippets')
            end
          end

          return sources
        end,
        per_filetype = {
          codecompanion = { 'codecompanion', 'buffer' },
        },
      },
      appearance = {
        kind_icons = require('icons').icons.kinds,
      },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)

      -- Extend neovim's client capabilities with the completion ones.
      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
    end,
  },
}
