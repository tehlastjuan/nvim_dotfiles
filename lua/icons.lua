local M = {}

M.diagnostics = {
  ERROR = ' ',
  WARN  = ' ',
  HINT  = ' ',
  INFO  = ' ',
}

M.arrows = {
  right = ' ',
  left  = ' ',
  up    = ' ',
  down  = ' ',
}

M.git = {
  added    = ' ',
  modified = ' ',
  removed  = ' ',
}

M.kinds = {
  Array         = ' ',
  Boolean       = '󰨙 ',
  Class         = ' ',
  Codeium       = '󰘦 ',
  Color         = ' ',
  Control       = ' ',
  Collapsed     = ' ',
  Constant      = '󰏿 ',
  Constructor   = ' ',
  Copilot       = ' ',
  Enum          = ' ',
  EnumMember    = ' ',
  Event         = ' ',
  Field         = ' ',
  File          = ' ',
  Folder        = ' ',
  Function      = '󰊕 ',
  Interface     = ' ',
  Key           = ' ',
  Keyword       = ' ',
  Method        = '󰊕 ',
  Module        = ' ',
  Namespace     = '󰦮 ',
  Null          = ' ',
  Number        = '󰎠 ',
  Object        = ' ',
  Operator      = ' ',
  Package       = ' ',
  Property      = ' ',
  Reference     = ' ',
  Snippet       = '󱄽 ',
  String        = ' ',
  Struct        = '󰆼 ',
  Supermaven    = ' ',
  TabNine       = '󰏚 ',
  Text          = ' ',
  TypeParameter = ' ',
  Unit          = ' ',
  Value         = ' ',
  Variable      = '󰀫 ',
}

M.dap = {
  Stopped             = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
  Breakpoint          = ' ',
  BreakpointCondition = ' ',
  BreakpointRejected  = { ' ', 'DiagnosticError' },
  LogPoint            = '.>',
}

M.misc = {
  dots = '󰇘',
}

M.ft = {
  octo = '',
}

return M
