return {

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        LazyVim.lsp.on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  --   version = false, -- telescope did only one release, so use HEAD for now
  --   dependencies = {
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = have_make and "make"
  --         or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  --       enabled = have_make or have_cmake,
  --       config = function(plugin)
  --         LazyVim.on_load("telescope.nvim", function()
  --           local ok, err = pcall(require("telescope").load_extension, "fzf")
  --           if not ok then
  --             local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
  --             if not vim.uv.fs_stat(lib) then
  --               LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
  --               require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
  --                 LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
  --               end)
  --             else
  --               LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
  --             end
  --           end
  --         end)
  --       end,
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>,",
  --       "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
  --       desc = "Switch Buffer",
  --     },
  --     { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
  --     { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  --     { "<leader><space>", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
  --     -- find
  --     { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
  --     { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
  --     { "<leader>ff", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
  --     { "<leader>fF", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
  --     { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
  --     { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  --     { "<leader>fR", LazyVim.pick("oldfiles"), desc = "Recent (cwd)" },
  --     -- git
  --     { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
  --     { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
  --     -- search
  --     { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
  --     { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  --     { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  --     { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  --     { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  --     { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
  --     { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
  --     { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
  --     { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
  --     { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  --     { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
  --     { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
  --     { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  --     { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
  --     { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  --     { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
  --     { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  --     { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  --     { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
  --     { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
  --     { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
  --     { "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
  --     { "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
  --     { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
  --     {
  --       "<leader>ss",
  --       function()
  --         require("telescope.builtin").lsp_document_symbols({
  --           symbols = require("lazyvim.config").get_kind_filter(),
  --         })
  --       end,
  --       desc = "Goto Symbol",
  --     },
  --     {
  --       "<leader>sS",
  --       function()
  --         require("telescope.builtin").lsp_dynamic_workspace_symbols({
  --           symbols = require("lazyvim.config").get_kind_filter(),
  --         })
  --       end,
  --       desc = "Goto Symbol (Workspace)",
  --     },
  --   },
  --
  --   opts = function()
  --     local actions = require("telescope.actions")
  --
  --     local open_with_trouble = require("trouble.sources.telescope").open
  --     local find_files_no_ignore = function()
  --       local action_state = require("telescope.actions.state")
  --       local line = action_state.get_current_line()
  --       LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
  --     end
  --     local find_files_with_hidden = function()
  --       local action_state = require("telescope.actions.state")
  --       local line = action_state.get_current_line()
  --       LazyVim.pick("find_files", { hidden = true, default_text = line })()
  --     end
  --
  --     return {
  --       defaults = {
  --         prompt_prefix = " ",
  --         selection_caret = " ",
  --         -- open files in the first window that is an actual file.
  --         -- use the current window if no other window is available.
  --         get_selection_window = function()
  --           local wins = vim.api.nvim_list_wins()
  --           table.insert(wins, 1, vim.api.nvim_get_current_win())
  --           for _, win in ipairs(wins) do
  --             local buf = vim.api.nvim_win_get_buf(win)
  --             if vim.bo[buf].buftype == "" then
  --               return win
  --             end
  --           end
  --           return 0
  --         end,
  --         mappings = {
  --           i = {
  --             ["<c-t>"] = open_with_trouble,
  --             ["<a-t>"] = open_with_trouble,
  --             ["<a-i>"] = find_files_no_ignore,
  --             ["<a-h>"] = find_files_with_hidden,
  --             ["<C-Down>"] = actions.cycle_history_next,
  --             ["<C-Up>"] = actions.cycle_history_prev,
  --             ["<C-a>"] = actions.preview_scrolling_down,
  --             ["<C-s>"] = actions.preview_scrolling_up,
  --           },
  --           n = {
  --             ["q"] = actions.close,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    pin = false,
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      icons = {
				breadcrumb = '»',
				separator = '󰁔  ', -- ➜
        mappings = false,
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
        wk.register(opts.defaults)
      end
    end,
  },

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = "LazyFile",
  --   opts = {
  --     signs = {
  --       add = { text = "+" },
  --       change = { text = "~" },
  --       delete = { text = "_" },
  --       topdelete = { text = "‾" },
  --       changedelete = { text = "~" },
  --       untracked = { text = "?" },
  --     },
  --     signs_staged = {
  --       add = { text = "▎" },
  --       change = { text = "▎" },
  --       delete = { text = "" },
  --       topdelete = { text = "" },
  --       changedelete = { text = "▎" },
  --     },
  --     on_attach = function(buffer)
  --       local gs = package.loaded.gitsigns
  --
  --       local function map(mode, l, r, desc)
  --         vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  --       end
  --
  --       -- stylua: ignore start
  --       map("n", "]h", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal({ "]c", bang = true })
  --         else
  --           gs.nav_hunk("next")
  --         end
  --       end, "Next Hunk")
  --       map("n", "[h", function()
  --         if vim.wo.diff then
  --           vim.cmd.normal({ "[c", bang = true })
  --         else
  --           gs.nav_hunk("prev")
  --         end
  --       end, "Prev Hunk")
  --       map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
  --       map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
  --       map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
  --       map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
  --       map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
  --       map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
  --       map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
  --       map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
  --       map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
  --       map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
  --       map("n", "<leader>ghd", gs.diffthis, "Diff This")
  --       map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
  --       map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
  --     end,
  --   },
  -- },

  -- better diagnostics list and others
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

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  --{
  --  import = "lazyvim.plugins.extras.editor.fzf",
  --  enabled = function()
  --    return LazyVim.pick.want() == "fzf"
  --  end,
  --},
  -- {
  --   import = "lazyvim.plugins.extras.editor.telescope",
  --   enabled = function()
  --     return LazyVim.pick.want() == "telescope"
  --   end,
  -- },
}
