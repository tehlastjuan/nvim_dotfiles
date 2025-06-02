-- Custom OneDark

-- Reset highlighting.
vim.cmd.highlight 'clear'
if vim.fn.exists 'syntax_on' then
    vim.cmd.syntax 'reset'
end
vim.o.termguicolors = true
vim.g.colors_name = 'custom-onedark'

local colors = {
    black = "#151820",
    bg = "#1e222a",
    bg0 = "#242b38",
    bg1 = "#2d3343",
    bg2 = "#343e4f",
    bg3 = "#363c51",
    bg4 = "#546178",

    fg = '#a5b0c5',

    grey = "#546178",
    light_grey = "#7d899f",

    selection = '#2d3343',
    gutter_fg = '#2d3343',
    nontext = "#343e4f",
    visual = "#363c51",
    comment = "#546178",

    bright_white = '#FF0000',
    white = '#00FF00',

    -- black
    transparent_black = "#242b38",

    -- cyan
    cyan = '#4dbdcb',
    bright_cyan = '#7adcd7',
    dark_cyan = '#25747d',

    -- green
    green = '#98c379',
    bright_green = '#ace98e',
    dark_green = '#303d27',

    -- blue
    blue = '#61afef',
    bright_blue = '#73ccfe',
    dark_blue = '#265478',

    -- magenta
    purple = '#ca72e4',
    bright_purple = '#da9ef2',
    dark_purple = '#8f36a9',
    transparent_blue = '#19272C',

    --orange
    orange = '#d99a5e',

    -- red
    red = '#be5046',
    bright_red = '#e06c75',
    dark_red = '#3c2729',

    -- yellow
    yellow = '#ebc275',
    bright_yellow = '#f0d197',
    dark_yellow = '#9a6b16',
}

-- Terminal colors.
--vim.g.terminal_color_0 = colors.transparent_black
--vim.g.terminal_color_1 = colors.red
--vim.g.terminal_color_2 = colors.green
--vim.g.terminal_color_3 = colors.yellow
--vim.g.terminal_color_4 = colors.blue
--vim.g.terminal_color_5 = colors.purple
--vim.g.terminal_color_6 = colors.cyan
--vim.g.terminal_color_7 = colors.white
--vim.g.terminal_color_8 = colors.selection
--vim.g.terminal_color_9 = colors.bright_red
--vim.g.terminal_color_10 = colors.bright_green
--vim.g.terminal_color_11 = colors.bright_yellow
--vim.g.terminal_color_12 = colors.bright_blue
--vim.g.terminal_color_13 = colors.bright_purple
--vim.g.terminal_color_14 = colors.bright_cyan
--vim.g.terminal_color_15 = colors.bright_white
--vim.g.terminal_color_background = colors.bg
--vim.g.terminal_color_foreground = colors.fg

---@type table<string, vim.api.keyset.highlight>
local groups = {

    -- Builtins.
    Normal = { fg = colors.fg, bg = colors.bg },
    Terminal = {fg = colors.fg, bg = colors.bg },
    EndOfBuffer = { fg = colors.bg },
    FoldColumn = {},
    Folded = { bg = colors.bg0 },
    SignColumn = { bg = colors.bg },
    ToolbarLine = { fg = colors.fg },
    Cursor = { fmt = "reverse" },
    vCursor = { fmt = "reverse" },
    iCursor = { fmt = "reverse" },
    lCursor = { fmt = "reverse" },
    CursorIM = {fmt = "reverse"},
    CursorColumn = { bg = colors.bg0 },
    CursorLine = { bg = colors.selection },
    CursorLineNr = { fg = colors.fg, bold = true },
    LineNr = { fg = colors.comment },
    Conceal = { fg = colors.comment },

    ColorColumn = { bg = colors.bg1 },
    Comment = { fg = colors.grey, italic = true },
    CurSearch = { fg = colors.black, bg = colors.bright_yellow },
    Directory = { fg = colors.cyan },
    ErrorMsg = { fg = colors.bright_red },
    IncSearch = { link = 'CurSearch' },
    Label = { fg = colors.cyan },
    MatchParen = { sp = colors.fg, underline = true },
    NonText = { fg = colors.nontext },
    NormalFloat = { fg = colors.fg, bg = colors.bg },
    Pmenu = { fg = colors.white, bg = colors.transparent_blue },
    PmenuSbar = { bg = colors.transparent_blue },
    PmenuSel = { fg = colors.cyan, bg = colors.selection },
    PmenuThumb = { bg = colors.selection },
    Question = { fg = colors.blue },
    Repeat = { fg = colors.purple },
    Search = { fg = colors.bg, bg = colors.orange },
    SpecialComment = { fg = colors.comment, italic = true },
    SpecialKey = { fg = colors.nontext },
    SpellBad = { sp = colors.bright_red, underline = true },
    SpellCap = { sp = colors.yellow, underline = true },
    SpellLocal = { sp = colors.yellow, underline = true },
    SpellRare = { sp = colors.yellow, underline = true },
    Substitute = { fg = colors.bright_yellow, bg = colors.orange, bold = true },
    Underlined = { fg = colors.cyan, underline = true },
    VertSplit = { fg = colors.blue },
    Visual = { bg = colors.visual },
    VisualNOS = { fg = colors.visual },
    WarningMsg = { fg = colors.yellow },
    WildMenu = { fg = colors.bg0, bg = colors.white },

    -- Status line.
    StatusLine = { fg = colors.white, bg = colors.bg },
    StatusLineTerm = {fg = colors.fg, bg = colors.bg2},
    StatusLineNC = {fg = colors.fg, bg = colors.bg1},
    StatusLineTermNC = {fg = colors.fg, bg = colors.bg1},

    -- Syntax.
    Boolean = { fg = colors.orange },
    Character = { fg = colors.orange },
    Conditional = { fg = colors.purple },
    Constant = { fg = colors.yellow },
    Define = { fg = colors.blue },
    Error = { fg = colors.bright_red },
    Function = { fg = colors.yellow },
    Float = { fg = colors.green },
    Identifier = { fg = colors.red },
    Include = { fg = colors.blue },
    Keyword = { fg = colors.cyan },
    Number = { fg = colors.green },
    Macro = { fg = colors.blue },
    Operator = { fg = colors.purple },
    PreCondit = { fg = colors.cyan },
    PreProc = { fg = colors.yellow },
    Statement = { fg = colors.blue },
    String = {fg = colors.green },
    StorageClass = { fg = colors.purple },
    Structure = { fg = colors.yellow },
    Special = { fg = colors.green, italic = true },
    Tag = { fg = colors.cyan },
    Title = { fg = colors.cyan },
    Type = { fg = colors.cyan },
    TypeDef = { fg = colors.yellow },
    Todo = { bg = colors.purple, bold = true, italic = true },

    -- Treesitter.
    ['@annotation'] = { fg = colors.yellow },
    ['@attribute'] = { fg = colors.cyan },
    ['@boolean'] = { fg = colors.purple },
    ['@character'] = { fg = colors.green },
    ['@constant'] = { fg = colors.blue },
    ['@constant.builtin'] = { fg = colors.blue },
    ['@constant.macro'] = { fg = colors.cyan },
    ['@constructor'] = { fg = colors.cyan },
    ['@error'] = { fg = colors.bright_red },
    ['@function'] = { fg = colors.green },
    ['@function.builtin'] = { fg = colors.cyan },
    ['@function.macro'] = { fg = colors.green },
    ['@function.method'] = { fg = colors.green },
    ['@keyword'] = { fg = colors.purple },
    ['@keyword.conditional'] = { fg = colors.purple },
    ['@keyword.exception'] = { fg = colors.blue },
    ['@keyword.function'] = { fg = colors.cyan },
    ['@keyword.function.ruby'] = { fg = colors.purple },
    ['@keyword.include'] = { fg = colors.purple },
    ['@keyword.operator'] = { fg = colors.purple },
    ['@keyword.repeat'] = { fg = colors.purple },
    ['@label'] = { fg = colors.cyan },
    ['@markup'] = { fg = colors.orange },
    ['@markup.emphasis'] = { fg = colors.yellow, italic = true },
    ['@markup.heading'] = { fg = colors.purple, bold = true },
    ['@markup.link'] = { fg = colors.orange, bold = true },
    ['@markup.link.uri'] = { fg = colors.yellow, italic = true },
    ['@markup.list'] = { fg = colors.cyan },
    ['@markup.raw'] = { fg = colors.yellow },
    ['@markup.strong'] = { fg = colors.orange, bold = true },
    ['@markup.underline'] = { fg = colors.orange },
    ['@module'] = { fg = colors.orange },
    ['@number'] = { fg = colors.blue },
    ['@number.float'] = { fg = colors.green },
    ['@operator'] = { fg = colors.purple },
    ['@parameter.reference'] = { fg = colors.orange },
    ['@property'] = { fg = colors.blue },
    ['@punctuation.bracket'] = { fg = colors.fg },
    ['@punctuation.delimiter'] = { fg = colors.fg },
    ['@string'] = { fg = colors.bright_green },
    ['@string.escape'] = { fg = colors.cyan },
    ['@string.regexp'] = { fg = colors.bright_red },
    ['@string.special.symbol'] = { fg = colors.blue },
    ['@structure'] = { fg = colors.blue },
    ['@tag'] = { fg = colors.cyan },
    ['@tag.attribute'] = { fg = colors.green },
    ['@tag.delimiter'] = { fg = colors.cyan },
    ['@type'] = { fg = colors.bright_cyan },
    ['@type.builtin'] = { fg = colors.cyan, italic = true },
    ['@type.qualifier'] = { fg = colors.purple },
    ['@variable'] = { fg = colors.fg },
    ['@variable.builtin'] = { fg = colors.blue },
    ['@variable.member'] = { fg = colors.orange },
    ['@variable.parameter'] = { fg = colors.orange },

    -- Semantic tokens.
    ['@class'] = { fg = colors.cyan },
    ['@decorator'] = { fg = colors.cyan },
    ['@enum'] = { fg = colors.cyan },
    ['@enumMember'] = { fg = colors.blue },
    ['@event'] = { fg = colors.cyan },
    ['@interface'] = { fg = colors.cyan },
    ['@lsp.type.class'] = { fg = colors.cyan },
    ['@lsp.type.decorator'] = { fg = colors.green },
    ['@lsp.type.enum'] = { fg = colors.cyan },
    ['@lsp.type.enumMember'] = { fg = colors.blue },
    ['@lsp.type.function'] = { fg = colors.green },
    ['@lsp.type.interface'] = { fg = colors.cyan },
    ['@lsp.type.macro'] = { fg = colors.cyan },
    ['@lsp.type.method'] = { fg = colors.green },
    ['@lsp.type.namespace'] = { fg = colors.orange },
    ['@lsp.type.parameter'] = { fg = colors.orange },
    ['@lsp.type.property'] = { fg = colors.blue },
    ['@lsp.type.struct'] = { fg = colors.cyan },
    ['@lsp.type.type'] = { fg = colors.bright_cyan },
    ['@lsp.type.variable'] = { fg = colors.fg },
    ['@modifier'] = { fg = colors.cyan },
    ['@regexp'] = { fg = colors.yellow },
    ['@struct'] = { fg = colors.cyan },
    ['@typeParameter'] = { fg = colors.cyan },

    -- Package manager.
    LazyDimmed = { fg = colors.grey },

    -- LSP.
    DiagnosticDeprecated = { strikethrough = true, fg = colors.fg },
    DiagnosticError = { fg = colors.red },
    DiagnosticFloatingError = { fg = colors.red },
    DiagnosticFloatingHint = { fg = colors.cyan },
    DiagnosticFloatingInfo = { fg = colors.cyan },
    DiagnosticFloatingWarn = { fg = colors.yellow },
    DiagnosticHint = { fg = colors.cyan },
    DiagnosticInfo = { fg = colors.cyan },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.cyan },
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.cyan },
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
    DiagnosticUnnecessary = { fg = colors.grey, italic = true },
    DiagnosticVirtualTextError = { fg = colors.red, bg = colors.dark_red },
    DiagnosticVirtualTextHint = { fg = colors.cyan, bg = colors.transparent_blue },
    DiagnosticVirtualTextInfo = { fg = colors.cyan, bg = colors.transparent_blue },
    DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.dark_yellow },
    DiagnosticWarn = { fg = colors.yellow },
    LspCodeLens = { fg = colors.cyan },
    LspFloatWinBorder = { fg = colors.comment },
    LspInlayHint = { fg = colors.bright_blue, italic = true },
    LspReferenceRead = { bg = colors.transparent_blue },
    LspReferenceText = {},
    LspReferenceWrite = { bg = colors.dark_red },
    LspSignatureActiveParameter = { bold = true, underline = true, sp = colors.fg },

    -- Completions:
    BlinkCmpKindClass = { link = '@type' },
    BlinkCmpKindColor = { link = 'DevIconCss' },
    BlinkCmpKindConstant = { link = '@constant' },
    BlinkCmpKindConstructor = { link = '@type' },
    BlinkCmpKindEnum = { link = '@variable.member' },
    BlinkCmpKindEnumMember = { link = '@variable.member' },
    BlinkCmpKindEvent = { link = '@constant' },
    BlinkCmpKindField = { link = '@variable.member' },
    BlinkCmpKindFile = { link = 'Directory' },
    BlinkCmpKindFolder = { link = 'Directory' },
    BlinkCmpKindFunction = { link = '@function' },
    BlinkCmpKindInterface = { link = '@type' },
    BlinkCmpKindKeyword = { link = '@keyword' },
    BlinkCmpKindMethod = { link = '@function.method' },
    BlinkCmpKindModule = { link = '@module' },
    BlinkCmpKindOperator = { link = '@operator' },
    BlinkCmpKindProperty = { link = '@property' },
    BlinkCmpKindReference = { link = '@parameter.reference' },
    BlinkCmpKindSnippet = { link = '@markup' },
    BlinkCmpKindStruct = { link = '@structure' },
    BlinkCmpKindText = { link = '@markup' },
    BlinkCmpKindTypeParameter = { link = '@variable.parameter' },
    BlinkCmpKindUnit = { link = '@variable.member' },
    BlinkCmpKindValue = { link = '@variable.member' },
    BlinkCmpKindVariable = { link = '@variable' },
    BlinkCmpLabelDeprecated = { link = 'DiagnosticDeprecated' },
    BlinkCmpLabelDescription = { fg = colors.grey, italic = true },
    BlinkCmpLabelDetail = { fg = colors.grey, bg = colors.bg },
    BlinkCmpMenu = { bg = colors.bg },
    BlinkCmpMenuBorder = { bg = colors.bg },

    -- Dap UI.
    DapStoppedLine = { default = true, link = 'Visual' },
    NvimDapVirtualText = { fg = colors.bright_blue, underline = true },

    -- Diffs.
    DiffAdd = { fg = colors.green, bg = colors.dark_green },
    DiffChange = { fg = colors.white, bg = colors.dark_yellow },
    DiffDelete = { fg = colors.red, bg = colors.dark_red },
    DiffText = { fg = colors.orange, bg = colors.dark_yellow, bold = true },
    DiffviewFolderSign = { fg = colors.cyan },
    DiffviewNonText = { fg = colors.dark_blue },
    diffAdded = { fg = colors.bright_green, bold = true },
    diffChanged = { fg = colors.bright_yellow, bold = true },
    diffRemoved = { fg = colors.bright_red, bold = true },

    -- Command line.
    MoreMsg = { fg = colors.bright_white, bold = true },
    MsgArea = { fg = colors.fg },
    MsgSeparator = { fg = colors.blue },

    -- Winbar styling.
    WinBar = { fg = colors.fg, bg = colors.bg0 },
    WinBarNC = { bg = colors.bg0 },
    WinBarDir = { fg = colors.bright_cyan, bg = colors.bg0, italic = true },
    WinBarSeparator = { fg = colors.cyan, bg = colors.bg0 },

    -- Quickfix window.
    QuickFixLine = { italic = true, bg = colors.dark_red },

    -- Gitsigns.
    GitSignsAdd = { fg = colors.bright_green },
    GitSignsChange = { fg = colors.cyan },
    GitSignsDelete = { fg = colors.bright_red },
    GitSignsStagedAdd = { fg = colors.orange },
    GitSignsStagedChange = { fg = colors.orange },
    GitSignsStagedDelete = { fg = colors.orange },

    -- Bufferline.
    BufferLineBufferSelected = { bg = colors.bg, underline = true, sp = colors.blue },
    BufferLineFill = { bg = colors.bg },
    TabLine = { fg = colors.comment, bg = colors.bg },
    TabLineFill = { bg = colors.bg },
    TabLineSel = { bg = colors.blue },

    -- When triggering flash, use a white font and make everything in the backdrop italic.
    FlashBackdrop = { italic = true },
    FlashPrompt = { link = 'Normal' },

    -- Make these titles more visible.
    MiniClueTitle = { bold = true, fg = colors.cyan },
    MiniFilesTitleFocused = { bold = true, fg = colors.cyan },

    -- Nicer yanky highlights.
    YankyPut = { link = 'Visual' },
    YankyYanked = { link = 'Visual' },

    -- Highlight for the Treesitter sticky context.
    TreesitterContextBottom = { underline = true, sp = colors.dark_blue },

    -- Fzf overrides.
    FzfLuaBorder = { fg = colors.comment },
    FzfLuaHeaderBind = { fg = colors.bright_blue },
    FzfLuaHeaderText = { fg = colors.purple },
    FzfLuaLivePrompt = { link = 'Normal' },
    FzfLuaLiveSym = { fg = colors.yellow },
    FzfLuaPreviewTitle = { fg = colors.fg },
    FzfLuaSearch = { bg = colors.dark_red },

    -- Nicer sign column highlights for grug-far.
    GrugFarResultsChangeIndicator = { link = 'Changed' },
    GrugFarResultsRemoveIndicator = { link = 'Removed' },
    GrugFarResultsAddIndicator = { link = 'Added' },

    -- Overseeer.
    OverseerComponent = { link = '@keyword' },

    -- Links.
    HighlightUrl = { underline = true, fg = colors.dark_cyan, sp = colors.dark_cyan },

    -- Trouble.
    TroubleNormal = { bg = colors.bg },
    TroubleNormalNC = { bg = colors.bg },

    -- Neotree.
    NeoTreeExpander = { bg = colors.bg },
    NeoTreeNormal = { bg = colors.bg },
    NeoTreeNormalNC = { bg = colors.bg },
    NeoTreeSignColumn = { bg = colors.bg },
    NeoTreeStats = { bg = colors.bg },
    NeoTreeStatsHeader = { bg = colors.bg },
    NeoTreeStatusLine = { fg = colors.bg3, bg = colors.bg },
    NeoTreeStatusLineNC = { fg = colors.bg3, bg = colors.bg },
    NeoTreeVertSplit = { fg = colors.bg3, bg = colors.bg },
    NeoTreeWinSeparator = { fg = colors.bg3, bg = colors.bg },
    NeoTreeEndOfBuffer = { bg = colors.bg },
    NeoTreeRootName = { bg = colors.bg },
    NeoTreeSymbolicLinkTarget = { bg = colors.bg },
    NeoTreeTitleBar = { bg = colors.bg },
    NeoTreeBufferNumber = { bg = colors.bg },
    -- NeoTreeCursorLine = { bg = colors.bg },
    NeoTreeDimText = { bg = colors.bg },
    -- NeoTreeDirectoryIcon = { bg = colors.bg },
    -- NeoTreeDirectoryName = { bg = colors.bg },
    -- NeoTreeDotfile = { bg = colors.bg },
    -- NeoTreeFileIcon = { bg = colors.bg },
    -- NeoTreeFileName = { bg = colors.bg },
    -- NeoTreeFileNameOpened = { bg = colors.bg },
    -- NeoTreeFilterTerm = { bg = colors.bg },
    NeoTreeFloatBorder = { fg = colors.bg3, bg = colors.bg0 },
    NeoTreeFloatTitle = { fg = colors.fg, bg = colors.bg0 },
    NeoTreeFloatNormal = { fg = colors.fg, bg = colors.bg0 },

    -- Misc.
    NormalFloat = { bg = colors.bg0 },
    SnippetTabstop = { bg = colors.bg },
    FloatBorder = { fg = colors.bg3, bg = colors.bg },
    WhichKeyFloat = { bg = colors.bg0 },
    MasonNormal = { bg = colors.bg0 },
    LazyNormal = { bg = colors.bg0 },
    TelescopePromptNormal = { bg = colors.bg0 },
    BufferLineOffsetSeparator = { fg = colors.bg3, bg = colors.bg },
    -- LspInfoTip = { fg = colors.fg, bg = colors.bg0 },
}

-- Groups used for statusline.
---@type table<string, vim.api.keyset.highlight>
-- local statusline_groups = {}
-- for mode, color in pairs {
--     Normal  = colors.green,
--     Pending = colors.blue,
--     Visual  = colors.purple,
--     Insert  = colors.cyan,
--     Command = colors.yellow,
--     Other   = colors.orange,
-- } do
--     statusline_groups['StatuslineMode' .. mode] = {
--         fg = color,
--         bg = colors.transparent_black
--     }
--     statusline_groups['StatuslineModeSeparator' .. mode] = {
--         fg = colors.transparent_black,
--         bg = color
--     }
-- end
-- 
-- statusline_groups = vim.tbl_extend('error', statusline_groups, {
--     StatuslineItalic = {
--         fg = colors.grey,
--         bg = colors.transparent_black, italic = true
--     },
--     StatuslineSpinner = {
--         fg = colors.bright_green,
--         bg = colors.transparent_black, bold = true
--     },
--     StatuslineTitle = {
--         fg = colors.bright_white,
--         bg = colors.transparent_black, bold = true
--     },
-- })

--for group, opts in pairs(groups) do
--    vim.api.nvim_set_hl(0, group, opts)
--end

for group_name, group_settings in pairs(groups) do
    vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=%s guisp=%s gui=%s", group_name,
        group_settings.fg or "none",
        group_settings.bg or "none",
        group_settings.sp or "none",
        group_settings.fmt or "none"))
end

