local M = {}

M.icons = {
  dap = {
    Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint          = " ",
    BreakpointCondition = " ",
    BreakpointRejected  = { " ", "DiagnosticError" },
    LogPoint            = ".>",
  },
  ft = {
    octo                = "", -- 
  },
  misc = {
    bug                 = " ",
    dashed_bar          = "┊",
    ellipsis            = "…", -- 󰇘
    fileModified        = "󱪗 ",
    git                 = " ", --  󰘬
    palette             = "󰏘 ",
    robot               = "󰚩 ",
    search              = " ",
    spinner             = "󱥸 ",
    terminal            = " ",
    toolbox             = "󰦬 ",
    vertical_bar        = "│",
    vim                 = " ",
  },
  diagnostics = {
    Error               = " ",
    Warn                = " ",
    Hint                = " ", -- 
    Info                = " ",
    ERROR               = " ",
    WARN                = " ",
    HINT                = " ", -- 
    INFO                = " ",

  },
  git = {
    added               = " ",
    modified            = " ",
    removed             = " ",
  },
  kinds = {
    Array               = " ",
    Boolean             = "󰨙 ",
    Class               = " ",
    Codeium             = "󰘦 ",
    Color               = "󰏘 ",
    Control             = " ",
    Collapsed           = " ",
    Constant            = "󰏿 ",
    Constructor         = " ",
    Copilot             = " ",
    Enum                = "󰕅 ",
    EnumMember          = " ",
    Event               = " ",
    Field               = " ",
    File                = " ",
    Folder              = "󰉋 ",
    Function            = "󰊕 ",
    Interface           = " ",
    Key                 = "󰌋 ",
    Keyword             = " ",
    Method              = "󰊕 ",
    Module              = " ",
    Namespace           = "󰦮 ",
    Null                = " ",
    Number              = "󰎠 ",
    Object              = " ",
    Operator            = " ",
    Package             = " ",
    Property            = " ",
    Reference           = " ",
    Snippet             = "󱄽 ",
    String              = " ",
    Struct              = " ",
    Supermaven          = " ",
    TabNine             = "󰏚 ",
    Text                = " ",
    TypeParameter       = " ",
    Unit                = " ",
    Value               = " ",
    Variable            = "󰀫 ",
  },
}

---@type table<string, string[]|boolean>?
M.kind_filter = {
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
}

return M
