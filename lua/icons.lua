local M = {}

--stylua: ignore
M.dap = {
  Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint          = " ",
  BreakpointCondition = " ",
  BreakpointRejected  = { " ", "DiagnosticError" },
  LogPoint            = ".>",
}

--stylua: ignore
M.ft = {
  octo                = "", -- 
}

--stylua: ignore
M.misc = {
  bug                 = " ",
  dashed_bar          = "┊",
  ellipsis            = "…", -- 󰇘
  fileModified        = "󱪗 ",
  git                 = " ", --  󰘬
  palette             = "󰏘 ",
  robot               = "󰚩 ",
  search              = " ",
  spinner             = "󱥸 ",
  terminal            = " ",
  toolbox             = "󰦬 ",
  vertical_bar        = "│",
  vim                 = " ",
}

--stylua: ignore
M.diagnostics = {
  Error               = " ",
  Warn                = " ",
  Hint                = " ", -- 
  Info                = " ",
  ERROR               = " ",
  WARN                = " ",
  HINT                = " ", -- 
  INFO                = " ",
}

--stylua: ignore
M.git = {
  added               = " ",
  modified            = " ",
  removed             = " ",
}

--stylua: ignore
M.kinds = {
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
}

--stylua: ignore
M.packages = {
  installed           = "●",
  pending             = "…",
  uninstalled         = "○",
}

--stylua: ignore
M.lazy = {
  cmd                 = " ",
  config              = "",
  debug               = " ",
  event               = "",
  ft                  = " ",
  import              = " ",
  init                = " ",
  keys                = " ",
  lazy                = "󰒲 ",
  list                = { "●", "➜", "★", "‒" },
  loaded              = "●",
  not_loaded          = "○",
  plugin              = " ",
  require             = "󰢱 ",
  runtime             = " ",
  source              = " ",
  start               = "",
  task                = "✔ ",
}

--stylua: ignore
M.trouble = {
  indent = {
    top               = "┊ ",
    middle            = "├╴",
    last              = "└╴",
    fold_open         = " ",
    fold_closed       = " ",
    ws                = "  ",
  },
  folder_closed       = " ",
  folder_open         = " ",
  kinds = {
    Array             = " ",
    Boolean           = "󰨙 ",
    Class             = " ",
    Constant          = "󰏿 ",
    Constructor       = " ",
    Enum              = " ",
    EnumMember        = " ",
    Event             = " ",
    Field             = " ",
    File              = " ",
    Function          = "󰊕 ",
    Interface         = " ",
    Key               = " ",
    Method            = "󰊕 ",
    Module            = " ",
    Namespace         = "󰦮 ",
    Null              = " ",
    Number            = "󰎠 ",
    Object            = " ",
    Operator          = " ",
    Package           = " ",
    Property          = " ",
    String            = " ",
    Struct            = "󰆼 ",
    TypeParameter     = " ",
    Variable          = "󰀫 ",
  },
}

--stylua: ignore
M.borders = {
  dashed    = { "┄", "┊", "┄", "┊", "╭", "╮", "╯", "╰", },
  double    = { "═", "║", "═", "║", "╔", "╗", "╝", "╚", },
  single    = { "─", "│", "─", "│", "╭", "╮", "╯", "╰", },
  blocks    = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙", },
  blocky    = { "▀", "▐", "▄", "▌", "▄", "▄", "▓", "▀", },
}

--stylua: ignore
M.telescope = {
  prompt    = { "─", "│", "─", "│", "╭", "╮", "╯", "╰", },
  results   = { "─", " ", "─", "│", "╭", "─", "─", "╰", },
  preview   = { "─", "│", "─", "│", "─", "╮", "╯", "╰", },
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
