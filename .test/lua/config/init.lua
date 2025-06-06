_G.LazyVim = require("util")

---@class LazyVimConfig: LazyVimOptions
local M = {}

M.version = "12.25.0" -- x-release-please-version
LazyVim.config = M

---@class LazyVimOptions
local defaults = {
  defaults = {
    autocmds = true, -- lazyvim.config.autocmds
    keymaps = true, -- lazyvim.config.keymaps
  },
  icons = {
    ft = {
      octo = "", -- 
    },
    misc = {
      bug = " ",
      dashed_bar = "┊",
      ellipsis = "…", -- 󰇘
      fileModified = "󱪗",
      git = " ", --  󰘬
      palette = "󰏘 ",
      robot = "󰚩 ",
      search = " ",
      spinner = "󱥸 ",
      terminal = " ",
      toolbox = "󰦬 ",
      vertical_bar = "│",
      vim = " ",
    },
    dap = {
      Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = " ",
      BreakpointCondition = " ",
      BreakpointRejected = { " ", "DiagnosticError" },
      LogPoint = ".>",
    },

    diagnostics = {
      Error = " ",
      Warn = " ",
      Hint = " ", -- 
      Info = " ",
    },
    git = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    kinds = {
      Array = " ",
      Boolean = "󰨙 ",
      Class = " ",
      Codeium = "󰘦 ",
      Color = "󰏘 ",
      Control = " ",
      Collapsed = " ",
      Constant = "󰏿 ",
      Constructor = " ",
      Copilot = " ",
      Enum = "󰕅 ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = "󰉋 ",
      Function = "󰊕 ",
      Interface = " ",
      Key = "󰌋 ",
      Keyword = " ",
      Method = "󰊕 ",
      Module = " ",
      Namespace = "󰦮 ",
      Null = " ",
      Number = "󰎠 ",
      Object = " ",
      Operator = " ",
      Package = " ",
      Property = " ",
      Reference = " ",
      Snippet = "󱄽 ",
      String = " ",
      Struct = " ",
      Supermaven = " ",
      TabNine = "󰏚 ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = "󰀫 ",
    },
  },
  ---@type table<string, string[]|boolean>?
  kind_filter = {
    default = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Package",
      "Property",
      "Struct",
      "Trait",
    },
    markdown = false,
    help = false,
    -- you can specify a different filter for each filetype
    lua = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      -- "Package", -- remove package since luals uses it for control flow structures
      "Property",
      "Struct",
      "Trait",
    },
  },
}

M.json = {
  version = 6,
  path = vim.g.lazyvim_json or vim.fn.stdpath("config") .. "/lazyvim.json",
  data = {
    version = nil, ---@type string?
    news = {}, ---@type table<string, string>
    extras = {}, ---@type string[]
  },
}

function M.json.load()
  local path = vim.fn.stdpath("config") .. "/lazyvim.json"
  local f = io.open(path, "r")
  if f then
    local data = f:read("*a")
    f:close()
    local ok, json = pcall(vim.json.decode, data, { luanil = { object = true, array = true } })
    if ok then
      M.json.data = vim.tbl_deep_extend("force", M.json.data, json or {})
      if M.json.data.version ~= M.json.version then
        LazyVim.json.migrate()
      end
    end
  end
end

---@type LazyVimOptions
local options

---@param opts? LazyVimOptions
function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}

  -- autocmds can be loaded lazily when not opening a file
  local lazy_autocmds = vim.fn.argc(-1) == 0
  if not lazy_autocmds then
    M.load("autocmds")
  end

  local group = vim.api.nvim_create_augroup("LazyVim", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      if lazy_autocmds then
        M.load("autocmds")
      end
      M.load("keymaps")

      -- if lazy_clipboard ~= nil then
      --   vim.opt.clipboard = lazy_clipboard
      -- end

      LazyVim.format.setup()
      LazyVim.root.setup()

      vim.api.nvim_create_user_command("LazyExtras", function()
        LazyVim.extras.show()
      end, { desc = "Manage LazyVim extras" })

      vim.api.nvim_create_user_command("LazyHealth", function()
        vim.cmd([[Lazy! load all]])
        vim.cmd([[checkhealth]])
      end, { desc = "Load all plugins and run :checkhealth" })

      local health = require("lazy.health")
      vim.list_extend(health.valid, {
        "recommended",
        "desc",
        "vscode",
      })

      -- Check lazy.nvim import order
      local imports = require("lazy.core.config").spec.modules
      local function find(pat, last)
        for i = last and #imports or 1, last and 1 or #imports, last and -1 or 1 do
          if imports[i]:find(pat) then
            return i
          end
        end
      end
      local lazyvim_plugins = find("^plugins$")
      local extras = find("^plugins%.extras%.", true) or lazyvim_plugins
      local plugins = find("^plugins$") or math.huge
      if lazyvim_plugins ~= 1 or extras > plugins then
        local msg = {
          "The order of your `lazy.nvim` imports is incorrect:",
          "- `lazyvim.plugins` should be first",
          "- followed by any `lazyvim.plugins.extras`",
          "- and finally your own `plugins`",
          "",
          "If you think you know what you're doing, you can disable this check with:",
          "```lua",
          "vim.g.lazyvim_check_order = false",
          "```",
        }
        vim.notify(table.concat(msg, "\n"), "warn", { title = "LazyVim" })
      end
    end,
  })

  -- Use Telescope by default.
  ---@return "telescope" | "fzf" | "snacks"
  LazyVim.pick.want = function()
    vim.g.lazyvim_picker = vim.g.lazyvim_picker or "auto"
    if vim.g.lazyvim_picker == "auto" then
      return LazyVim.has_extra("editor.snacks_picker") and "snacks"
        or LazyVim.has_extra("editor.fzf") and "fzf"
        or "telescope"
    end
    return vim.g.lazyvim_picker
  end

  LazyVim.extras.sources = {
    {
      name = "LazyVim",
      desc = "LazyVim extras",
      module = "plugins.extras",
    },
    {
      name = "User",
      desc = "User extras",
      module = "plugins.user.extras",
    },
  }
end

---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local ft = vim.bo[buf].filetype
  if M.kind_filter == false then
    return
  end
  if M.kind_filter[ft] == false then
    return
  end
  if type(M.kind_filter[ft]) == "table" then
    ---@diagnostic disable-next-line: return-type-mismatch
    return M.kind_filter[ft]
  end
  ---@diagnostic disable-next-line: return-type-mismatch
  return type(M.kind_filter) == "table" and type(M.kind_filter.default) == "table" and M.kind_filter.default or nil
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local function _load(mod)
    if require("lazy.core.cache").find(mod)[1] then
      LazyVim.try(function()
        require(mod)
      end, { msg = "Failed loading " .. mod })
    end
  end

  local pattern = "LazyVim" .. name:sub(1, 1):upper() .. name:sub(2)
  -- always load lazyvim, then user file
  if M.defaults[name] or name == "options" then
    _load("config." .. name)
    vim.api.nvim_exec_autocmds("User", { pattern = pattern .. "Defaults", modeline = false })
  end
  _load("config." .. name)
  if vim.bo.filetype == "lazy" then
    -- HACK: LazyVim may have overwritten options of the Lazy ui, so reset this here
    vim.cmd([[do VimResized]])
  end
  vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

M.did_init = false
function M.init()
  if M.did_init then
    return
  end
  M.did_init = true
  local plugin = require("lazy.core.config").spec.plugins.LazyVim
  if plugin then
    vim.opt.rtp:append(plugin.dir)
  end

  package.preload["plugins.lsp.format"] = function()
    LazyVim.deprecate([[require("plugins.lsp.format")]], [[LazyVim.format]])
    return LazyVim.format
  end

  -- delay notifications till vim.notify was replaced or after 500ms
  LazyVim.lazy_notify()

  -- load options here, before lazy init while sourcing plugin modules
  -- this is needed to make sure options will be correctly applied
  -- after installing missing plugins

  M.load("options")
  M.load("autocmds")
  M.load("keymaps")

  -- defer built-in clipboard handling: "xsel" and "pbcopy" can be slow
  -- lazy_clipboard = vim.opt.clipboard
  -- vim.opt.clipboard = ""

  --if vim.g.deprecation_warnings == false then
  --  vim.deprecate = function() end
  --end

  LazyVim.plugin.setup()
  M.json.load()
end

setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end
    ---@cast options LazyVimConfig
    return options[key]
  end,
})

return M
