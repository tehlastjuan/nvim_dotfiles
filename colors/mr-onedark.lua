-- Color dimming.
local util = {}

util.bg = "#000000"
util.fg = "#ffffff"

local function hexToRgb(hex_str)
	local hex = "[abcdef0-9][abcdef0-9]"
	local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
	hex_str = string.lower(hex_str)

	assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

	local r, g, b = string.match(hex_str, pat)
	return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function util.blend(fg, bg, alpha)
	bg = hexToRgb(bg)
	fg = hexToRgb(fg)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function util.darken(hex, amount, bg)
	return util.blend(hex, bg or util.bg, math.abs(amount))
end

function util.lighten(hex, amount, fg)
	return util.blend(hex, fg or util.fg, math.abs(amount))
end

-- Reset highlightings.
vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") then
	vim.cmd.syntax("reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "mr-onedark"

local cfg = {
	transparent = false,
	term_colors = false,
	ending_tildes = false,
	cmp_itemkind_reverse = true,

	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},

	diagnostics = {
		darker = true,
		undercurl = true,
		background = true,
	},
}

local colors = {
	black            = "#151820",
	bg               = "#1e222a",
	bg0              = "#242b38",
	bg1              = "#2d3343",
	bg2              = "#343e4f",
	bg3              = "#363c51",
	grey             = "#546178",
	light_grey       = "#7d899f",
	fg               = "#a5b0c5",
	-- cyan
	bright_cyan      = "#7adcd7",
	cyan             = "#4dbdcb",
	dark_cyan        = "#25747d",
	-- green
	green            = "#98c379",
	bright_green     = "#ace98e",
	dark_green       = "#303d27",
	-- blue
	bright_blue      = "#73ccfe",
	blue             = "#61afef",
	dark_blue        = "#265478",
	transparent_blue = "#19272C",
	-- magenta
	bright_purple    = "#da9ef2",
	purple           = "#ca72e4",
	dark_purple      = "#8f36a9",
	--orange
	orange           = "#d99a5e",
	-- red
	bright_red       = "#e06c75",
	red              = "#be5046",
	dark_red         = "#3c2729",
	-- yellow
	bright_yellow    = "#f0d197",
	yellow           = "#ebc275",
	dark_yellow      = "#9a6b16",
}

-- Terminal colors.
vim.g.terminal_color_0 = colors.black
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.purple
vim.g.terminal_color_5 = colors.pink
vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_7 = colors.white
vim.g.terminal_color_8 = colors.selection
vim.g.terminal_color_9 = colors.bright_red
vim.g.terminal_color_10 = colors.bright_green
vim.g.terminal_color_11 = colors.bright_yellow
vim.g.terminal_color_12 = colors.bright_blue
vim.g.terminal_color_13 = colors.bright_magenta
vim.g.terminal_color_14 = colors.bright_cyan
vim.g.terminal_color_15 = colors.bright_white
vim.g.terminal_color_background = colors.bg
vim.g.terminal_color_foreground = colors.fg

local hl = {
	---@type table<string, vim.api.keyset.highlight>
	statusline = {},
	---@type table<string, vim.api.keyset.highlight>
	common = {},
	---@type table<string, vim.api.keyset.highlight>
	syntax = {},
	---@type table<string, vim.api.keyset.highlight>
	treesitter = {},
	---@type table<string, vim.api.keyset.highlight>
	lsp = {},
	---@type table<string, vim.api.keyset.highlight>
	langs = {},
	---@type table<string, vim.api.keyset.highlight>
	plugins = {},
}

for mode, color in pairs({
	Normal  = "green",
	Pending = "yellow",
	Visual  = "purple",
	Insert  = "blue",
	Command = "blue",
	Other   = "orange",
}) do
	hl.statusline["StatuslineMode" .. mode] = { fg = colors.bg, bg = colors[color] }
	hl.statusline["StatuslineSep" .. mode] = { fg = colors[color], bg = colors.bg1 }
end

hl.statusline = vim.tbl_extend("error", hl.statusline, {
	StatuslineRegular   = { fg = colors.fg, bg = colors.bg1 },
	StatuslineItalic    = { fg = colors.fg, bg = colors.bg1, fmt = "italic" },
	StatuslineBold      = { fg = colors.fg, bg = colors.bg1, fmt = "bold" },
	StatuslineSpinner   = { fg = colors.bright_green, bg = colors.bg1, fmt = "bold" },
	StatuslineDir       = { fg = colors.orange, bg = colors.bg1, fmt = "bold" },
	StatuslineGitAdd    = { fg = colors.bright_green, bg = colors.bg1 },
	StatuslineGitMod    = { fg = colors.bright_blue, bg = colors.bg1 },
	StatuslineGitRem    = { fg = colors.bright_red, bg = colors.bg1 },
	StatuslineFileMod   = { fg = colors.red, bg = colors.bg1 },
	StatuslineFileUnMod = { fg = colors.bg1, bg = colors.bg1 },
	StatuslineCols      = { fg = colors.blue, bg = colors.bg1 },
	StatuslineLines     = { fg = colors.fg, bg = colors.bg1 },
})

hl.common = {
	Added = { fg = colors.green },
	Changed = { fg = colors.blue },
	ColorColumn = { bg = colors.bg1 },
	Conceal = { fg = colors.light_grey, bg = colors.bg0 },
	CurSearch = { fg = colors.bg, bg = colors.orange },
	Cursor = { fmt = "reverse" },
	CursorColumn = { bg = colors.bg0 },
	CursorIM = { fmt = "reverse" },
	CursorLine = { bg = colors.bg0 },
	CursorLineNr = { fg = colors.fg },
	Debug = { fg = colors.yellow },
	DiffAdd = { fg = colors.none, bg = colors.dark_green },
	DiffAdded = { fg = colors.green },
	DiffChange = { fg = colors.none, bg = colors.transparent_blue },
	DiffChanged = { fg = colors.blue },
	DiffDelete = { fg = colors.none, bg = colors.dark_red },
	DiffDeleted = { fg = colors.red },
	DiffFile = { fg = colors.cyan },
	DiffIndexLine = { fg = colors.grey },
	DiffRemoved = { fg = colors.red },
	DiffText = { fg = colors.none, bg = colors.dark_blue },
	Directory = { fg = colors.blue },
	EndOfBuffer = { fg = colors.bg, bg = colors.bg },
	ErrorMsg = { fg = colors.bright_red, fmt = "bold" },
	FloatBorder = { fg = colors.bg1, bg = colors.bg1 },
	FoldColumn = { fg = colors.bg2, bg = colors.bg },
	Folded = { fg = colors.fg, bg = colors.bg },
	IncSearch = { fg = colors.bg, bg = colors.orange },
	LineNr = { fg = colors.grey },
	MatchParen = { fg = colors.none, bg = colors.grey },
	MoreMsg = { fg = colors.blue, fmt = "bold" },
	NonText = { fg = colors.bg3 },
	Normal = { fg = colors.fg, bg = colors.bg },
	NormalFloat = { fg = colors.fg, bg = colors.bg1 },
	Pmenu = { fg = colors.fg, bg = colors.bg1 },
	PmenuSbar = { fg = colors.none, bg = colors.bg1 },
	PmenuSel = { fg = colors.bg, bg = colors.blue },
	PmenuThumb = { fg = colors.none, bg = colors.grey },
	Question = { fg = colors.yellow },
	QuickFixLine = { fg = colors.blue, fmt = "underline" },
	Removed = { fg = colors.red },
	Search = { fg = colors.bg, bg = colors.bright_yellow },
	SignColumn = { fg = colors.fg, bg = colors.bg },
	SpecialKey = { fg = colors.grey },
	SpellBad = { fg = colors.none, fmt = "undercurl", sp = colors.red },
	SpellCap = { fg = colors.none, fmt = "undercurl", sp = colors.yellow },
	SpellLocal = { fg = colors.none, fmt = "undercurl", sp = colors.blue },
	SpellRare = { fg = colors.none, fmt = "undercurl", sp = colors.purple },
	StatusLine = { fg = colors.fg, bg = colors.bg1 },
	StatusLineNC = { fg = colors.grey, bg = colors.bg },
	StatusLineTerm = { fg = colors.fg, bg = colors.bg1 },
	StatusLineTermNC = { fg = colors.grey, bg = colors.bg },
	Substitute = { fg = colors.bg, bg = colors.green },
	TabLine = { fg = colors.fg, bg = colors.bg1 },
	TabLineFill = { fg = colors.grey, bg = colors.bg1 },
	TabLineSel = { fg = colors.bg, bg = colors.fg },
	Terminal = { fg = colors.fg, bg = colors.bg },
	ToolbarButton = { fg = colors.bg, bg = colors.blue },
	ToolbarLine = { fg = colors.fg },
	Visual = { bg = colors.bg3 },
	VisualNOS = { fg = colors.none, bg = colors.bg2, fmt = "underline" },
	WarningMsg = { fg = colors.yellow, fmt = "bold" },
	Whitespace = { fg = colors.bg1 },
	WildMenu = { fg = colors.bg, bg = colors.blue },
	WinSeparator = { fg = colors.bg3 },
	WinBar = { fg = colors.light_grey, bg = colors.bg, fmt = "none" },
	WinBarDir = { fg = colors.orange, bg = colors.bg, fmt = "none" },
	WinBarNC = { bg = colors.bg },
	WinBarSeparator = { fg = colors.cyan, bg = colors.bg },
	debugBreakpoint = { fg = colors.bg, bg = colors.red },
	debugPC = { fg = colors.bg, bg = colors.green },
	iCursor = { fmt = "reverse" },
	lCursor = { fmt = "reverse" },
	vCursor = { fmt = "reverse" },
}

hl.syntax = {
	Boolean = { fg = colors.orange },
	Character = { fg = colors.orange },
	Comment = { fg = colors.grey, fmt = cfg.code_style.comments },
	Conditional = { fg = colors.purple, fmt = cfg.code_style.keywords },
	Constant = { fg = colors.cyan },
	Define = { fg = colors.purple },
	Delimiter = { fg = colors.light_grey },
	Error = { fg = colors.purple },
	Exception = { fg = colors.purple },
	Float = { fg = colors.orange },
	Function = { fg = colors.blue, fmt = cfg.code_style.functions },
	Identifier = { fg = colors.bright_red, fmt = cfg.code_style.variables },
	Include = { fg = colors.purple },
	Keyword = { fg = colors.purple, fmt = cfg.code_style.keywords },
	Label = { fg = colors.purple },
	Macro = { fg = colors.bright_red },
	Number = { fg = colors.orange },
	Operator = { fg = colors.purple },
	PreCondit = { fg = colors.purple },
	PreProc = { fg = colors.purple },
	Repeat = { fg = colors.purple, fmt = cfg.code_style.keywords },
	Special = { fg = colors.bright_red },
	SpecialChar = { fg = colors.bright_red },
	SpecialComment = { fg = colors.grey, fmt = cfg.code_style.comments },
	Statement = { fg = colors.purple },
	StorageClass = { fg = colors.yellow },
	String = { fg = colors.green, fmt = cfg.code_style.strings },
	Structure = { fg = colors.yellow },
	Tag = { fg = colors.green },
	Title = { fg = colors.cyan },
	Todo = { fg = colors.bright_red, fmt = cfg.code_style.comments },
	Type = { fg = colors.yellow },
	Typedef = { fg = colors.yellow },
}

hl.treesitter = {
	-- nvim-treesitter@0.9.2 and after
	["@annotation"] = { fg = colors.fg },
	["@attribute"] = { fg = colors.cyan },
	["@attribute.typescript"] = { fg = colors.blue },
	["@boolean"] = { fg = colors.orange },
	["@character"] = { fg = colors.orange },
	["@comment"] = { fg = colors.grey, fmt = cfg.code_style.comments },
	["@comment.todo"] = hl.syntax.Todo,
	["@comment.todo.checked"] = { fg = colors.green, fmt = cfg.code_style.comments },
	["@comment.todo.unchecked"] = { fg = colors.red, fmt = cfg.code_style.comments },
	["@constant"] = { fg = colors.orange, fmt = cfg.code_style.constants },
	["@constant.builtin"] = { fg = colors.orange, fmt = cfg.code_style.constants },
	["@constant.macro"] = { fg = colors.orange, fmt = cfg.code_style.constants },
	["@constructor"] = { fg = colors.yellow, fmt = "bold" },
	["@danger"] = { fg = colors.fg },
	["@diff.add"] = hl.common.DiffAdded,
	["@diff.delete"] = hl.common.DiffDeleted,
	["@diff.delta"] = hl.common.DiffChanged,
	["@diff.minus"] = hl.common.DiffDeleted,
	["@diff.plus"] = hl.common.DiffAdded,
	["@error"] = { fg = colors.fg },
	["@function"] = { fg = colors.blue, fmt = cfg.code_style.functions },
	["@function.builtin"] = { fg = colors.cyan, fmt = cfg.code_style.functions },
	["@function.macro"] = { fg = colors.cyan, fmt = cfg.code_style.functions },
	["@function.method"] = { fg = colors.blue, fmt = cfg.code_style.functions },
	["@keyword"] = { fg = colors.purple, fmt = cfg.code_style.keywords },
	["@keyword.conditional"] = { fg = colors.purple, fmt = cfg.code_style.keywords },
	["@keyword.directive"] = { fg = colors.purple },
	["@keyword.exception"] = { fg = colors.purple },
	["@keyword.function"] = { fg = colors.purple, fmt = cfg.code_style.functions },
	["@keyword.import"] = { fg = colors.purple },
	["@keyword.operator"] = { fg = colors.purple, fmt = cfg.code_style.keywords },
	["@keyword.repeat"] = { fg = colors.purple, fmt = cfg.code_style.keywords },
	["@label"] = { fg = colors.bright_red },
	["@markup.emphasis"] = { fg = colors.fg, fmt = "italic" },
	["@markup.environment"] = { fg = colors.fg },
	["@markup.environment.name"] = { fg = colors.fg },
	["@markup.heading"] = { fg = colors.orange, fmt = "bold" },
	["@markup.heading.1.markdown"] = { fg = colors.bright_red, fmt = "bold" },
	["@markup.heading.2.markdown"] = { fg = colors.purple, fmt = "bold" },
	["@markup.heading.3.markdown"] = { fg = colors.orange, fmt = "bold" },
	["@markup.heading.4.markdown"] = { fg = colors.red, fmt = "bold" },
	["@markup.heading.5.markdown"] = { fg = colors.purple, fmt = "bold" },
	["@markup.heading.6.markdown"] = { fg = colors.orange, fmt = "bold" },
	["@markup.heading.1.marker.markdown"] = { fg = colors.bright_red, fmt = "bold" },
	["@markup.heading.2.marker.markdown"] = { fg = colors.purple, fmt = "bold" },
	["@markup.heading.3.marker.markdown"] = { fg = colors.orange, fmt = "bold" },
	["@markup.heading.4.marker.markdown"] = { fg = colors.red, fmt = "bold" },
	["@markup.heading.5.marker.markdown"] = { fg = colors.purple, fmt = "bold" },
	["@markup.heading.6.marker.markdown"] = { fg = colors.orange, fmt = "bold" },
	["@markup.link"] = { fg = colors.blue },
	["@markup.link.url"] = { fg = colors.cyan, fmt = "underline" },
	["@markup.list"] = { fg = colors.bright_red },
	["@markup.math"] = { fg = colors.fg },
	["@markup.raw"] = { fg = colors.green },
	["@markup.strike"] = { fg = colors.fg, fmt = "strikethrough" },
	["@markup.strong"] = { fg = colors.fg, fmt = "bold" },
	["@markup.underline"] = { fg = colors.fg, fmt = "underline" },
	["@module"] = { fg = colors.yellow },
	["@none"] = { fg = colors.fg },
	["@note"] = { fg = colors.fg },
	["@number"] = { fg = colors.orange },
	["@number.float"] = { fg = colors.orange },
	["@operator"] = { fg = colors.fg },
	["@parameter.reference"] = { fg = colors.fg },
	["@property"] = { fg = colors.cyan },
	["@punctuation.bracket"] = { fg = colors.light_grey },
	["@punctuation.delimiter"] = { fg = colors.light_grey },
	["@string"] = { fg = colors.green, fmt = cfg.code_style.strings },
	["@string.escape"] = { fg = colors.red, fmt = cfg.code_style.strings },
	["@string.regexp"] = { fg = colors.orange, fmt = cfg.code_style.strings },
	["@string.special.symbol"] = { fg = colors.cyan },
	["@tag"] = { fg = colors.purple },
	["@tag.attribute"] = { fg = colors.yellow },
	["@tag.delimiter"] = { fg = colors.purple },
	["@text"] = { fg = colors.fg },
	["@type"] = { fg = colors.yellow },
	["@type.builtin"] = { fg = colors.orange },
	["@variable"] = { fg = colors.fg, fmt = cfg.code_style.variables },
	["@variable.builtin"] = { fg = colors.bright_red, fmt = cfg.code_style.variables },
	["@variable.member"] = { fg = colors.cyan },
	["@variable.parameter"] = { fg = colors.bright_red },
	["@warning"] = { fg = colors.fg },
	-- Semantic tokens.
	["@class"] = { fg = colors.yellow },
	["@decorator"] = { fg = colors.yellow },
	["@enum"] = { fg = colors.yellow },
	["@enumMember"] = { fg = colors.purple },
	["@event"] = { fg = colors.yellow },
	["@interface"] = { fg = colors.purple },
	["@modifier"] = { fg = colors.yellow },
	["@regexp"] = { fg = colors.purple },
	["@struct"] = { fg = colors.yellow },
	["@typeParameter"] = { fg = colors.yellow },
}

if vim.api.nvim_call_function("has", { "nvim-0.9" }) == 1 then
	hl.lsp = {
		["@lsp.type.builtinType"] = hl.treesitter["@type.builtin"],
		["@lsp.type.comment"] = hl.treesitter["@comment"],
		["@lsp.type.enum"] = hl.treesitter["@type"],
		["@lsp.type.enumMember"] = hl.treesitter["@constant.builtin"],
		["@lsp.type.generic"] = hl.treesitter["@text"],
		["@lsp.type.interface"] = hl.treesitter["@type"],
		["@lsp.type.keyword"] = hl.treesitter["@keyword"],
		["@lsp.type.macro"] = hl.treesitter["@function.macro"],
		["@lsp.type.method"] = hl.treesitter["@function.method"],
		["@lsp.type.namespace"] = hl.treesitter["@module"],
		["@lsp.type.number"] = hl.treesitter["@number"],
		["@lsp.type.parameter"] = hl.treesitter["@variable.parameter"],
		["@lsp.type.property"] = hl.treesitter["@property"],
		["@lsp.type.typeParameter"] = hl.treesitter["@type"],
		["@lsp.type.variable"] = hl.treesitter["@variable"],
		["@lsp.typemod.function.defaultLibrary"] = hl.treesitter["@function"],
		["@lsp.typemod.method.defaultLibrary"] = hl.treesitter["@function"],
		["@lsp.typemod.operator.injected"] = hl.treesitter["@operator"],
		["@lsp.typemod.string.injected"] = hl.treesitter["@string"],
		["@lsp.typemod.variable.defaultLibrary"] = hl.treesitter["@variable.builtin"],
		["@lsp.typemod.variable.injected"] = hl.treesitter["@variable"],
		["@lsp.typemod.variable.static"] = hl.treesitter["@constant"],
		-- Semantic tokens.
		["@lsp.type.class"] = hl.treesitter["@class"],
		["@lsp.type.decorator"] = hl.treesitter["@decorator"],
		["@lsp.type.function"] = hl.treesitter["@function"],
		["@lsp.type.struct"] = hl.treesitter["@struct"],
		["@lsp.type.type"] = hl.treesitter["@type"],
	}
end

local diagnostics_error_color = cfg.diagnostics.darker and colors.dark_red or colors.bright_red
local diagnostics_hint_color = cfg.diagnostics.darker and colors.dark_purple or colors.purple
local diagnostics_warn_color = cfg.diagnostics.darker and colors.dark_yellow or colors.yellow
local diagnostics_info_color = cfg.diagnostics.darker and colors.dark_cyan or colors.cyan

----- Plugins. -----

hl.plugins.lsp = {
	LspCxxHlGroupEnumConstant = { fg = colors.orange },
	LspCxxHlGroupMemberVariable = { fg = colors.orange },
	LspCxxHlGroupNamespace = { fg = colors.blue },
	LspCxxHlSkippedRegion = { fg = colors.grey },
	LspCxxHlSkippedRegionBeginEnd = { fg = colors.red },

	DiagnosticError = { fg = colors.bright_red },
	DiagnosticWarn = { fg = colors.yellow },
	DiagnosticHint = { fg = colors.purple },
	DiagnosticInfo = { fg = colors.cyan },

	DiagnosticVirtualTextError = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, colors.bg) or colors.none,
		fg = diagnostics_error_color,
	},
	DiagnosticVirtualTextWarn = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, colors.bg) or colors.none,
		fg = diagnostics_warn_color,
	},
	DiagnosticVirtualTextInfo = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, colors.bg) or colors.none,
		fg = diagnostics_info_color,
	},
	DiagnosticVirtualTextHint = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, colors.bg) or colors.none,
		fg = diagnostics_hint_color,
	},

	DiagnosticUnderlineError = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = colors.bright_red },
	DiagnosticUnderlineHint = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = colors.purple },
	DiagnosticUnderlineInfo = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = colors.blue },
	DiagnosticUnderlineWarn = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = colors.yellow },

	LspReferenceText = { bg = colors.bg2 },
	LspReferenceWrite = { bg = colors.bg2 },
	LspReferenceRead = { bg = colors.bg2 },

	LspCodeLens = { fg = colors.grey, fmt = cfg.code_style.comments },
	LspCodeLensSeparator = { fg = colors.grey },
}

--hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
--hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
--hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
--hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
--hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
--hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
--hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
--hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
--hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
--hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
--hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
--hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

hl.plugins.ale = {
	ALEErrorSign = hl.plugins.lsp.DiagnosticError,
	ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,
	ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.barbar = {
	BufferCurrent = { fmt = "bold" },
	BufferCurrentMod = { fg = colors.orange, fmt = "bold,italic" },
	BufferCurrentSign = { fg = colors.purple },
	BufferInactiveMod = { fg = colors.light_grey, bg = colors.bg1, fmt = "italic" },
	BufferVisible = { fg = colors.light_grey, bg = colors.bg },
	BufferVisibleMod = { fg = colors.yellow, bg = colors.bg, fmt = "italic" },
	BufferVisibleIndex = { fg = colors.light_grey, bg = colors.bg },
	BufferVisibleSign = { fg = colors.light_grey, bg = colors.bg },
	BufferVisibleTarget = { fg = colors.light_grey, bg = colors.bg },
}

hl.plugins.cmp = {
	CmpItemAbbr = { fg = colors.fg },
	CmpItemAbbrDeprecated = { fg = colors.light_grey, fmt = "strikethrough" },
	CmpItemAbbrMatch = { fg = colors.cyan },
	CmpItemAbbrMatchFuzzy = { fg = colors.cyan, fmt = "underline" },
	CmpItemMenu = { fg = colors.light_grey },
	CmpItemKind = { fg = colors.purple, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.blink = {
	BlinkCmpLabel = { fg = colors.fg },
	BlinkCmpLabelDeprecated = { fg = colors.light_grey, fmt = "strikethrough" },
	BlinkCmpLabelMatch = { fg = colors.cyan },
	BlinkCmpDetail = { fg = colors.light_grey },
	BlinkCmpKind = { fg = colors.purple },
}

hl.plugins.coc = {
	CocErrorSign = hl.plugins.lsp.DiagnosticError,
	CocHintSign = hl.plugins.lsp.DiagnosticHint,
	CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
	CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
	WhichKey = { fg = colors.bright_red },
	WhichKeyDesc = { fg = colors.blue },
	WhichKeyGroup = { fg = colors.orange },
	WhichKeySeparator = { fg = colors.green },
}

hl.plugins.gitgutter = {
	GitGutterAdd = { fg = colors.green },
	GitGutterChange = { fg = colors.blue },
	GitGutterDelete = { fg = colors.bright_red },
}

hl.plugins.hop = {
	HopNextKey = { fg = colors.red, fmt = "bold" },
	HopNextKey1 = { fg = colors.cyan, fmt = "bold" },
	HopNextKey2 = { fg = util.darken(colors.blue, 0.7) },
	HopUnmatched = { fg = colors.grey },
}

-- comment
hl.plugins.diffview = {
	DiffviewFilePanelTitle = { fg = colors.blue, fmt = "bold" },
	DiffviewFilePanelCounter = { fg = colors.purple, fmt = "bold" },
	DiffviewFilePanelFileName = { fg = colors.fg },
	DiffviewNormal = hl.common.Normal,
	DiffviewCursorLine = hl.common.CursorLine,
	DiffviewVertSplit = hl.common.VertSplit,
	DiffviewSignColumn = hl.common.SignColumn,
	DiffviewStatusLine = hl.common.StatusLine,
	DiffviewStatusLineNC = hl.common.StatusLineNC,
	DiffviewEndOfBuffer = hl.common.EndOfBuffer,
	DiffviewFilePanelRootPath = { fg = colors.grey },
	DiffviewFilePanelPath = { fg = colors.grey },
	DiffviewFilePanelInsertions = { fg = colors.green },
	DiffviewFilePanelDeletions = { fg = colors.bright_red },
	DiffviewStatusAdded = { fg = colors.green },
	DiffviewStatusUntracked = { fg = colors.blue },
	DiffviewStatusModified = { fg = colors.blue },
	DiffviewStatusRenamed = { fg = colors.blue },
	DiffviewStatusCopied = { fg = colors.blue },
	DiffviewStatusTypeChange = { fg = colors.blue },
	DiffviewStatusUnmerged = { fg = colors.blue },
	DiffviewStatusUnknown = { fg = colors.bright_red },
	DiffviewStatusDeleted = { fg = colors.bright_red },
	DiffviewStatusBroken = { fg = colors.red },
}

hl.plugins.gitsigns = {
	GitSignsAdd = { fg = colors.green },
	GitSignsAddLn = { fg = colors.green },
	GitSignsAddNr = { fg = colors.green },
	GitSignsChange = { fg = colors.blue },
	GitSignsChangeLn = { fg = colors.blue },
	GitSignsChangeNr = { fg = colors.blue },
	GitSignsDelete = { fg = colors.red },
	GitSignsDeleteLn = { fg = colors.red },
	GitSignsDeleteNr = { fg = colors.red },
}

hl.plugins.neo_tree = {
	NeoTreeBufferNumber = { bg = colors.bg },
	NeoTreeDimText = { bg = colors.bg },
	NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and colors.bg2 or colors.bg_d, bg = colors.bg },
	NeoTreeExpander = { bg = colors.bg },
	NeoTreeFloatBorder = { fg = colors.bg3, bg = colors.bg1 },
	NeoTreeFloatNormal = { fg = colors.fg, bg = colors.bg1 },
	NeoTreeFloatTitle = { fg = colors.fg, bg = colors.bg1 },
	NeoTreeGitAdded = { fg = colors.green },
	NeoTreeGitConflict = { fg = colors.red, fmt = "bold,italic" },
	NeoTreeGitDeleted = { fg = colors.red },
	NeoTreeGitModified = { fg = colors.yellow },
	NeoTreeGitUntracked = { fg = colors.red, fmt = "italic" },
	NeoTreeIndentMarker = { fg = colors.grey },
	NeoTreeNormal = { fg = colors.fg, bg = colors.bg },
	NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg },
	NeoTreeRootName = { fg = colors.orange, bg = colors.bg, fmt = "bold" },
	NeoTreeSignColumn = { bg = colors.bg },
	NeoTreeStats = { bg = colors.bg },
	NeoTreeStatsHeader = { bg = colors.bg },
	NeoTreeStatusLine = { fg = colors.bg3, bg = colors.bg },
	NeoTreeStatusLineNC = { fg = colors.bg3, bg = colors.bg },
	NeoTreeSymbolicLinkTarget = { fg = colors.cyan, bg = colors.bg },
	NeoTreeTitleBar = { bg = colors.bg },
	NeoTreeVertSplit = { fg = colors.bg3, bg = colors.bg },
	NeoTreeWinSeparator = { fg = colors.bg3, bg = colors.bg },
	-- NeoTreeCursorLine = { bg = colors.bg },
	-- NeoTreeDirectoryIcon = { bg = colors.bg },
	-- NeoTreeDirectoryName = { bg = colors.bg },
	-- NeoTreeDotfile = { bg = colors.bg },
	-- NeoTreeFileIcon = { bg = colors.bg },
	-- NeoTreeFileName = { bg = colors.bg },
	-- NeoTreeFileNameOpened = { bg = colors.bg },
	-- NeoTreeFilterTerm = { bg = colors.bg },
}

hl.plugins.neotest = {
	NeotestAdapterName = { fg = colors.purple, fmt = "bold" },
	NeotestDir = { fg = colors.cyan },
	NeotestExpandMarker = { fg = colors.grey },
	NeotestFailed = { fg = colors.red },
	NeotestFile = { fg = colors.cyan },
	NeotestFocused = { fmt = "bold,italic" },
	NeotestIndent = { fg = colors.grey },
	NeotestMarked = { fg = colors.orange, fmt = "bold" },
	NeotestNamespace = { fg = colors.blue },
	NeotestPassed = { fg = colors.green },
	NeotestRunning = { fg = colors.yellow },
	NeotestWinSelect = { fg = colors.cyan, fmt = "bold" },
	NeotestSkipped = { fg = colors.light_grey },
	NeotestTarget = { fg = colors.purple },
	NeotestTest = { fg = colors.fg },
	NeotestUnknown = { fg = colors.light_grey },
}

hl.plugins.nvim_tree = {
	NvimTreeNormal = { fg = colors.fg, bg = cfg.transparent and colors.none or colors.bg_d },
	NvimTreeNormalFloat = { fg = colors.fg, bg = cfg.transparent and colors.none or colors.bg_d },
	NvimTreeVertSplit = { fg = colors.bg_d, bg = cfg.transparent and colors.none or colors.bg_d },
	NvimTreeEndOfBuffer = {
		fg = cfg.ending_tildes and colors.bg2 or colors.bg_d,
		bg = cfg.transparent and colors.none or colors.bg_d,
	},
	NvimTreeRootFolder = { fg = colors.orange, fmt = "bold" },
	NvimTreeGitDirty = { fg = colors.yellow },
	NvimTreeGitNew = { fg = colors.green },
	NvimTreeGitDeleted = { fg = colors.red },
	NvimTreeSpecialFile = { fg = colors.yellow, fmt = "underline" },
	NvimTreeIndentMarker = { fg = colors.fg },
	NvimTreeImageFile = { fg = colors.dark_purple },
	NvimTreeSymlink = { fg = colors.purple },
	NvimTreeFolderName = { fg = colors.blue },
}

hl.plugins.telescope = {
	TelescopeBorder = { fg = colors.bright_red },
	TelescopeNormal = { bg = colors.bg },
	TelescopeMatching = { fg = colors.orange, fmt = "bold" },
	TelescopePromptBorder = { fg = colors.grey, bg = colors.bg },
	TelescopePromptNormal = { fg = colors.fg, bg = colors.bg },
	TelescopePromptPrefix = { fg = colors.green },
	TelescopePreviewBorder = { fg = colors.grey },
	TelescopeResultsBorder = { fg = colors.grey },
	TelescopeSelection = { bg = colors.bg1 },
	TelescopeSelectionCaret = { fg = colors.yellow, bg = colors.bg1 },
}

hl.plugins.fzf_lua = {
	FzfLuaNormal = { fg = colors.fg, bg = colors.bg },
	FzfLuaBorder = { fg = colors.grey, bg = colors.bg },
	FzfLuaTitle = { fg = colors.light_grey, bg = colors.bg },
	FzfLuaHelpBorder = { fg = colors.bright_red, bg = colors.bg },
	FzfLuaPreviewNormal = { fg = colors.fg, bg = colors.bg },
	FzfLuaPreviewBorder = { fg = colors.grey, bg = colors.bg },
	FzfLuaPreviewTitle = { fg = colors.light_grey, bg = colors.bg },
	FzfLuaCursorLine = { bg = colors.bg1, fmt = "none" },
	FzfLuaCursorLineNr = { bg = colors.bg1, fmt = "none" },
	FzfLuaFzfNormal = { fg = colors.fg, bg = colors.bg },
	FzfLuaFzfCursorLine = { bg = colors.bg1 },
	FzfLuaFzfMatch = { fg = colors.yellow, bg = colors.bg },
	FzfLuaFzfBorder = { fg = colors.grey, bg = colors.bg },
	FzfLuaFzfScrollbar = { fg = colors.cyan, bg = colors.bg },
	FzfLuaFzfSeparator = { fg = colors.bg2, bg = colors.bg },
	FzfLuaFzfGutter = { fg = colors.bright_red, bg = colors.bg },
	FzfLuaFzfHeader = { fg = colors.red, bg = colors.bg },
	FzfLuaFzfInfo = { fg = colors.blue, bg = colors.bg },
	FzfLuaFzfPointer = { fg = colors.bright_red, bg = colors.bg },
	FzfLuaFzfMarker = { fg = colors.blue, bg = colors.bg },
	FzfLuaFzfSpinner = { fg = colors.green, bg = colors.bg },
	FzfLuaFzfPrompt = { fg = colors.green, bg = colors.bg },
	FzfLuaFzfQuery = { fg = colors.bright_red, bg = colors.bg },
}

hl.plugins.snacks = {
	-- Dashboard
	SnacksDashboardHeader = { fg = colors.yellow },
	SnacksDashboardFooter = { fg = colors.dark_red, fmt = "italic" },
	SnacksDashboardSpecial = { fg = colors.dark_red, fmt = "bold" },
	SnacksDashboardDesc = { fg = colors.cyan },
	SnacksDashboardIcon = { fg = colors.cyan },
	SnacksDashboardKey = { fg = colors.blue },

	-- Picker
	SnacksPicker = hl.common.Normal,
	SnacksPickerBorder = { fg = colors.cyan },
	SnacksPickerTitle = { fg = colors.red },
	SnacksPickerMatch = { fg = colors.orange, fmt = "bold" },
}

hl.plugins.dashboard = {
	DashboardShortCut = { fg = colors.blue },
	DashboardHeader = { fg = colors.yellow },
	DashboardCenter = { fg = colors.cyan },
	DashboardFooter = { fg = colors.dark_red, fmt = "italic" },
}

hl.plugins.outline = {
	FocusedSymbol = { fg = colors.purple, bg = colors.bg2, fmt = "bold" },
	AerialLine = { fg = colors.purple, bg = colors.bg2, fmt = "bold" },
}

hl.plugins.navic = {
	NavicText = { fg = colors.fg },
	NavicSeparator = { fg = colors.light_grey },
}

hl.plugins.ts_rainbow = {
	rainbowcol1 = { fg = colors.light_grey },
	rainbowcol2 = { fg = colors.yellow },
	rainbowcol3 = { fg = colors.blue },
	rainbowcol4 = { fg = colors.orange },
	rainbowcol5 = { fg = colors.purple },
	rainbowcol6 = { fg = colors.green },
	rainbowcol7 = { fg = colors.red },
}

hl.plugins.ts_rainbow2 = {
	TSRainbowRed = { fg = colors.red },
	TSRainbowYellow = { fg = colors.yellow },
	TSRainbowBlue = { fg = colors.blue },
	TSRainbowOrange = { fg = colors.orange },
	TSRainbowGreen = { fg = colors.green },
	TSRainbowViolet = { fg = colors.purple },
	TSRainbowCyan = { fg = colors.cyan },
}

hl.plugins.rainbow_delimiters = {
	RainbowDelimiterRed = { fg = colors.red },
	RainbowDelimiterYellow = { fg = colors.yellow },
	RainbowDelimiterBlue = { fg = colors.blue },
	RainbowDelimiterOrange = { fg = colors.orange },
	RainbowDelimiterGreen = { fg = colors.green },
	RainbowDelimiterViolet = { fg = colors.purple },
	RainbowDelimiterCyan = { fg = colors.cyan },
}

hl.plugins.indent_blankline = {
	IndentBlanklineIndent1 = { fg = colors.blue },
	IndentBlanklineIndent2 = { fg = colors.green },
	IndentBlanklineIndent3 = { fg = colors.cyan },
	IndentBlanklineIndent4 = { fg = colors.light_grey },
	IndentBlanklineIndent5 = { fg = colors.purple },
	IndentBlanklineIndent6 = { fg = colors.red },
	IndentBlanklineChar = { fg = colors.bg1, fmt = "nocombine" },
	IndentBlanklineContextChar = { fg = colors.grey, fmt = "nocombine" },
	IndentBlanklineContextStart = { sp = colors.grey, fmt = "underline" },
	IndentBlanklineContextSpaceChar = { fmt = "nocombine" },

	-- Ibl v3
	IblIndent = { fg = colors.bg1, fmt = "nocombine" },
	IblWhitespace = { fg = colors.grey, fmt = "nocombine" },
	IblScope = { fg = colors.grey, fmt = "nocombine" },
}

hl.plugins.mini = {
	MiniAnimateCursor = { fmt = "reverse,nocombine" },
	MiniAnimateNormalFloat = hl.common.NormalFloat,

	MiniClueBorder = hl.common.FloatBorder,
	MiniClueDescGroup = hl.plugins.lsp.DiagnosticWarn,
	MiniClueDescSingle = hl.common.NormalFloat,
	MiniClueNextKey = hl.plugins.lsp.DiagnosticHint,
	MiniClueNextKeyWithPostkeys = hl.plugins.lsp.DiagnosticError,
	MiniClueSeparator = hl.plugins.lsp.DiagnosticInfo,
	MiniClueTitle = { fg = colors.cyan },

	MiniCompletionActiveParameter = { fmt = "underline" },

	MiniCursorword = { fmt = "underline" },
	MiniCursorwordCurrent = { fmt = "underline" },

	MiniDepsChangeAdded = hl.common.Added,
	MiniDepsChangeRemoved = hl.common.Removed,
	MiniDepsHint = hl.plugins.lsp.DiagnosticHint,
	MiniDepsInfo = hl.plugins.lsp.DiagnosticInfo,
	MiniDepsMsgBreaking = hl.plugins.lsp.DiagnosticWarn,
	MiniDepsPlaceholder = hl.syntax.Comment,
	MiniDepsTitle = hl.syntax.Title,
	MiniDepsTitleError = hl.common.DiffDelete,
	MiniDepsTitleSame = hl.common.DiffText,
	MiniDepsTitleUpdate = hl.common.DiffAdd,

	MiniDiffSignAdd = { fg = colors.green },
	MiniDiffSignChange = { fg = colors.blue },
	MiniDiffSignDelete = { fg = colors.red },
	MiniDiffOverAdd = hl.common.DiffAdd,
	MiniDiffOverChange = hl.common.DiffText,
	MiniDiffOverContext = hl.common.DiffChange,
	MiniDiffOverDelete = hl.common.DiffDelete,

	MiniFilesBorder = hl.common.FloatBorder,
	MiniFilesBorderModified = hl.plugins.lsp.DiagnosticWarn,
	MiniFilesCursorLine = { bg = colors.bg2 },
	MiniFilesDirectory = hl.common.Directory,
	MiniFilesFile = { fg = colors.fg },
	MiniFilesNormal = hl.common.NormalFloat,
	MiniFilesTitle = { fg = colors.cyan },
	MiniFilesTitleFocused = { fg = colors.cyan, fmt = "bold" },

	MiniHipatternsFixme = { fg = colors.bg, bg = colors.red, fmt = "bold" },
	MiniHipatternsHack = { fg = colors.bg, bg = colors.yellow, fmt = "bold" },
	MiniHipatternsNote = { fg = colors.bg, bg = colors.cyan, fmt = "bold" },
	MiniHipatternsTodo = { fg = colors.bg, bg = colors.purple, fmt = "bold" },

	MiniIconsAzure = { fg = colors.blue },
	MiniIconsBlue = { fg = colors.blue },
	MiniIconsCyan = { fg = colors.cyan },
	MiniIconsGreen = { fg = colors.green },
	MiniIconsGrey = { fg = colors.fg },
	MiniIconsOrange = { fg = colors.orange },
	MiniIconsPurple = { fg = colors.purple },
	MiniIconsRed = { fg = colors.red },
	MiniIconsYellow = { fg = colors.yellow },

	MiniIndentscopeSymbol = { fg = colors.grey },
	MiniIndentscopePrefix = { fmt = "nocombine" }, -- Make it invisible

	MiniJump = { fg = colors.purple, fmt = "underline", sp = colors.purple },

	MiniJump2dDim = { fg = colors.grey, fmt = "nocombine" },
	MiniJump2dSpot = { fg = colors.red, fmt = "bold,nocombine" },
	MiniJump2dSpotAhead = { fg = colors.cyan, bg = colors.bg, fmt = "nocombine" },
	MiniJump2dSpotUnique = { fg = colors.yellow, fmt = "bold,nocombine" },

	MiniMapNormal = hl.common.NormalFloat,
	MiniMapSymbolCount = hl.syntax.Special,
	MiniMapSymbolLine = hl.syntax.Title,
	MiniMapSymbolView = hl.syntax.Delimiter,

	MiniNotifyBorder = hl.common.FloatBorder,
	MiniNotifyNormal = hl.common.NormalFloat,
	MiniNotifyTitle = { fg = colors.cyan },

	MiniOperatorsExchangeFrom = hl.common.IncSearch,

	MiniPickBorder = hl.common.FloatBorder,
	MiniPickBorderBusy = hl.plugins.lsp.DiagnosticWarn,
	MiniPickBorderText = { fg = colors.cyan, fmt = "bold" },
	MiniPickIconDirectory = hl.common.Directory,
	MiniPickIconFile = hl.common.NormalFloat,
	MiniPickHeader = hl.plugins.lsp.DiagnosticHint,
	MiniPickMatchCurrent = { bg = colors.bg2 },
	MiniPickMatchMarked = { bg = colors.diff_text },
	MiniPickMatchRanges = hl.plugins.lsp.DiagnosticHint,
	MiniPickNormal = hl.common.NormalFloat,
	MiniPickPreviewLine = { bg = colors.bg2 },
	MiniPickPreviewRegion = hl.common.IncSearch,
	MiniPickPrompt = hl.plugins.lsp.DiagnosticInfo,

	MiniStarterCurrent = { fmt = "nocombine" },
	MiniStarterFooter = { fg = colors.dark_red, fmt = "italic" },
	MiniStarterHeader = { fg = colors.yellow },
	MiniStarterInactive = { fg = colors.grey, fmt = cfg.code_style.comments },
	MiniStarterItem = { fg = colors.fg, bg = cfg.transparent and colors.none or colors.bg },
	MiniStarterItemBullet = { fg = colors.grey },
	MiniStarterItemPrefix = { fg = colors.yellow },
	MiniStarterSection = { fg = colors.light_grey },
	MiniStarterQuery = { fg = colors.cyan },

	MiniStatuslineDevinfo = { fg = colors.fg, bg = colors.bg2 },
	MiniStatuslineFileinfo = { fg = colors.fg, bg = colors.bg2 },
	MiniStatuslineFilename = { fg = colors.grey, bg = colors.bg1 },
	MiniStatuslineInactive = { fg = colors.grey, bg = colors.bg },
	MiniStatuslineModeCommand = { fg = colors.bg, bg = colors.yellow, fmt = "bold" },
	MiniStatuslineModeInsert = { fg = colors.bg, bg = colors.blue, fmt = "bold" },
	MiniStatuslineModeNormal = { fg = colors.bg, bg = colors.green, fmt = "bold" },
	MiniStatuslineModeOther = { fg = colors.bg, bg = colors.cyan, fmt = "bold" },
	MiniStatuslineModeReplace = { fg = colors.bg, bg = colors.red, fmt = "bold" },
	MiniStatuslineModeVisual = { fg = colors.bg, bg = colors.purple, fmt = "bold" },

	MiniSurround = { fg = colors.bg, bg = colors.orange },

	MiniTablineCurrent = { fmt = "bold" },
	MiniTablineFill = { fg = colors.grey, bg = colors.bg1 },
	MiniTablineHidden = { fg = colors.fg, bg = colors.bg1 },
	MiniTablineModifiedCurrent = { fg = colors.orange, fmt = "bold,italic" },
	MiniTablineModifiedHidden = { fg = colors.light_grey, bg = colors.bg1, fmt = "italic" },
	MiniTablineModifiedVisible = { fg = colors.yellow, bg = colors.bg, fmt = "italic" },
	MiniTablineTabpagesection = { fg = colors.bg, bg = colors.bright_yellow },
	MiniTablineVisible = { fg = colors.light_grey, bg = colors.bg },

	MiniTestEmphasis = { fmt = "bold" },
	MiniTestFail = { fg = colors.red, fmt = "bold" },
	MiniTestPass = { fg = colors.green, fmt = "bold" },

	MiniTrailspace = { bg = colors.red },
}

hl.plugins.illuminate = {
	illuminatedWord = { bg = colors.bg2, fmt = "bold" },
	illuminatedCurWord = { bg = colors.bg2, fmt = "bold" },
	IlluminatedWordText = { bg = colors.bg2, fmt = "bold" },
	IlluminatedWordRead = { bg = colors.bg2, fmt = "bold" },
	IlluminatedWordWrite = { bg = colors.bg2, fmt = "bold" },
}

hl.plugins.trouble = {
	TroubleNormal = { bg = colors.bg },
	TroubleNormalNC = { bg = colors.bg },
}

hl.plugins.misc = {
	--BufferLineOffsetSeparator = { fg = colors.bg3, bg = colors.bg },
	LazyNormal = { bg = colors.bg0 },
  LazyProp = { fg = colors.light_grey, bg = colors.bg0 },
	MasonNormal = { bg = colors.bg0 },
	SnippetTabstop = { bg = colors.bg },
	TelescopePromptNormal = { bg = colors.bg0 },
	WhichKeyFloat = { bg = colors.bg0 },
}

--hl.plugins.snacks = {
--  Match = "Special",
--  Search = "Search",
--  Prompt = "Special",
--  InputSearch = "@keyword",
--  Special = "Special",
--  Label = "SnacksPickerSpecial",
--  Totals = "NonText",
--  File = "", -- basename of a file path
--  Link = "Comment",
--  LinkBroken = "DiagnosticError",
--  Directory = "Directory", -- basename of a directory path
--  PathIgnored = "NonText", -- any ignored file or directory
--  PathHidden = "NonText", -- any hidden file or directory
--  Dir = "NonText", -- dirname of a path
--  Toggle = "DiagnosticVirtualTextInfo",
--  Dimmed = "Conceal",
--  Row = "String",
--  Col = "LineNr",
--  Comment = "Comment",
--  Desc = "Comment",
--  Delim = "Delimiter",
--  Spinner = "Special",
--  Selected = "Number",
--  Cmd = "Function",
--  CmdBuiltin = "@constructor",
--  Unselected = "NonText",
--  Idx = "Number",
--  Bold = "Bold",
--  Tree = "LineNr",
--  Italic = "Italic",
--  Code = "@markup.raw.markdown_inline",
--  AuPattern = "String",
--  AuEvent = "Constant",
--  AuGroup = "Type",
--  DiagnosticCode = "Special",
--  DiagnosticSource = "Comment",
--  Register = "Number",
--  KeymapMode = "Number",
--  KeymapLhs = "Special",
--  KeymapNowait = "@variable.builtin",
--  BufNr = "Number",
--  BufFlags = "NonText",
--  KeymapRhs = "NonText",
--  Time = "Special",
--  UndoAdded = "Added",
--  UndoRemoved = "Removed",
--  UndoCurrent = "@variable.builtin",
--  UndoSaved = "Special",
--  GitCommit = "@variable.builtin",
--  GitBreaking = "Error",
--  GitDetached = "DiagnosticWarn",
--  GitBranch = "Title",
--  GitBranchCurrent = "Number",
--  GitDate = "Special",
--  GitIssue = "Number",
--  GitType = "Title", -- conventional commit type
--  GitScope = "Italic", -- conventional commit scope
--  GitStatus = "Special",
--  GitStatusAdded = "Added",
--  GitStatusModified = "DiagnosticWarn",
--  GitStatusDeleted = "Removed",
--  GitStatusRenamed = "SnacksPickerGitStatus",
--  GitStatusCopied = "SnacksPickerGitStatus",
--  GitStatusUntracked = "NonText",
--  GitStatusIgnored = "NonText",
--  GitStatusUnmerged = "DiagnosticError",
--  GitStatusStaged = "DiagnosticHint",
--  ManSection = "Number",
--  PickWin = "Search",
--  PickWinCurrent = "CurSearch",
--  LspDisabled = "DiagnosticWarn",
--  LspEnabled = "Special",
--  LspAttached = "DiagnosticWarn",
--  LspAttachedBuf = "DiagnosticInfo",
--  LspUnavailable = "DiagnosticError",
--  ManPage = "Special",
--
--  -- Icons
--  Icon = "Special",
--  IconSource = "@constant",
--  IconName = "@keyword",
--  IconCategory = "@module",
--
--  -- LSP Symbol Kinds
--  IconArray = "@punctuation.bracket",
--  IconBoolean = "@boolean",
--  IconClass = "@type",
--  IconConstant = "@constant",
--  IconConstructor = "@constructor",
--  IconEnum = "@lsp.type.enum",
--  IconEnumMember = "@lsp.type.enumMember",
--  IconEvent = "Special",
--  IconField = "@variable.member",
--  IconFile = "Normal",
--  IconFunction = "@function",
--  IconInterface = "@lsp.type.interface",
--  IconKey = "@lsp.type.keyword",
--  IconMethod = "@function.method",
--  IconModule = "@module",
--  IconNamespace = "@module",
--  IconNull = "@constant.builtin",
--  IconNumber = "@number",
--  IconObject = "@constant",
--  IconOperator = "@operator",
--  IconPackage = "@module",
--  IconProperty = "@property",
--  IconString = "@string",
--  IconStruct = "@lsp.type.struct",
--  IconTypeParameter = "@lsp.type.typeParameter",
--  IconVariable = hl.treesitter["@variable"],
--}

----- Langs -----

hl.langs.c = {
	cInclude = { fg = colors.blue },
	cStorageClass = { fg = colors.purple },
	cTypedef = { fg = colors.purple },
	cDefine = { fg = colors.cyan },
	cTSInclude = { fg = colors.blue },
	cTSConstant = { fg = colors.cyan },
	cTSConstMacro = { fg = colors.purple },
	cTSOperator = { fg = colors.purple },
}

hl.langs.cpp = {
	cppStatement = { fg = colors.purple, fmt = "bold" },
	cppTSInclude = { fg = colors.blue },
	cppTSConstant = { fg = colors.cyan },
	cppTSConstMacro = { fg = colors.purple },
	cppTSOperator = { fg = colors.purple },
}

hl.langs.markdown = {
	markdownBlockquote = { fg = colors.grey },
	markdownBold = { fg = colors.none, fmt = "bold" },
	markdownBoldDelimiter = { fg = colors.grey },
	markdownCode = { fg = colors.green },
	markdownCodeBlock = { fg = colors.green },
	markdownCodeDelimiter = { fg = colors.yellow },
	markdownH1 = { fg = colors.bright_red, fmt = "bold" },
	markdownH2 = { fg = colors.purple, fmt = "bold" },
	markdownH3 = { fg = colors.orange, fmt = "bold" },
	markdownH4 = { fg = colors.red, fmt = "bold" },
	markdownH5 = { fg = colors.purple, fmt = "bold" },
	markdownH6 = { fg = colors.orange, fmt = "bold" },
	markdownHeadingDelimiter = { fg = colors.grey },
	markdownHeadingRule = { fg = colors.grey },
	markdownId = { fg = colors.yellow },
	markdownIdDeclaration = { fg = colors.bright_red },
	markdownItalic = { fg = colors.none, fmt = "italic" },
	markdownItalicDelimiter = { fg = colors.grey, fmt = "italic" },
	markdownLinkDelimiter = { fg = colors.grey },
	markdownLinkText = { fg = colors.yellow },
	markdownLinkTextDelimiter = { fg = colors.grey },
	markdownListMarker = { fg = colors.bright_red },
	markdownOrderedListMarker = { fg = colors.bright_red },
	markdownRule = { fg = colors.purple },
	markdownUrl = { fg = colors.blue, fmt = "underline" },
	markdownUrlDelimiter = { fg = colors.grey },
	markdownUrlTitleDelimiter = { fg = colors.green },
}

hl.langs.php = {
	phpFunctions = { fg = colors.fg, fmt = cfg.code_style.functions },
	phpMethods = { fg = colors.cyan },
	phpStructure = { fg = colors.purple },
	phpOperator = { fg = colors.purple },
	phpMemberSelector = { fg = colors.fg },
	phpVarSelector = { fg = colors.orange, fmt = cfg.code_style.variables },
	phpIdentifier = { fg = colors.orange, fmt = cfg.code_style.variables },
	phpBoolean = { fg = colors.cyan },
	phpNumber = { fg = colors.orange },
	phpHereDoc = { fg = colors.green },
	phpNowDoc = { fg = colors.green },
	phpSCKeyword = { fg = colors.purple, fmt = cfg.code_style.keywords },
	phpFCKeyword = { fg = colors.purple, fmt = cfg.code_style.keywords },
	phpRegion = { fg = colors.blue },
}

hl.langs.scala = {
	scalaNameDefinition = { fg = colors.fg },
	scalaInterpolationBoundary = { fg = colors.purple },
	scalaInterpolation = { fg = colors.purple },
	scalaTypeOperator = { fg = colors.red },
	scalaOperator = { fg = colors.red },
	scalaKeywordModifier = { fg = colors.red, fmt = cfg.code_style.keywords },
}

hl.langs.tex = {
	latexTSInclude = { fg = colors.blue },
	latexTSFuncMacro = { fg = colors.fg, fmt = cfg.code_style.functions },
	latexTSEnvironment = { fg = colors.cyan, fmt = "bold" },
	latexTSEnvironmentName = { fg = colors.yellow },
	texCmdEnv = { fg = colors.cyan },
	texEnvArgName = { fg = colors.yellow },
	latexTSTitle = { fg = colors.green },
	latexTSType = { fg = colors.blue },
	latexTSMath = { fg = colors.orange },
	texMathZoneX = { fg = colors.orange },
	texMathZoneXX = { fg = colors.orange },
	texMathDelimZone = { fg = colors.light_grey },
	texMathDelim = { fg = colors.purple },
	texMathOper = { fg = colors.bright_red },
	texCmd = { fg = colors.purple },
	texCmdPart = { fg = colors.blue },
	texCmdPackage = { fg = colors.blue },
	texPgfType = { fg = colors.yellow },
}

hl.langs.vim = {
	vimOption = { fg = colors.bright_red },
	vimSetEqual = { fg = colors.yellow },
	vimMap = { fg = colors.purple },
	vimMapModKey = { fg = colors.orange },
	vimNotation = { fg = colors.bright_red },
	vimMapLhs = { fg = colors.fg },
	vimMapRhs = { fg = colors.blue },
	vimVar = { fg = colors.fg, fmt = cfg.code_style.variables },
	vimCommentTitle = { fg = colors.light_grey, fmt = cfg.code_style.comments },
}

local lsp_kind_icons_color = {
	Default = colors.purple,
	Array = colors.yellow,
	Boolean = colors.orange,
	Class = colors.yellow,
	Color = colors.green,
	Constant = colors.orange,
	Constructor = colors.blue,
	Enum = colors.purple,
	EnumMember = colors.yellow,
	Event = colors.yellow,
	Field = colors.purple,
	File = colors.blue,
	Folder = colors.orange,
	Function = colors.blue,
	Interface = colors.green,
	Key = colors.cyan,
	Keyword = colors.cyan,
	Method = colors.blue,
	Module = colors.orange,
	Namespace = colors.bright_red,
	Null = colors.grey,
	Number = colors.orange,
	Object = colors.bright_red,
	Operator = colors.bright_red,
	Package = colors.yellow,
	Property = colors.cyan,
	Reference = colors.orange,
	Snippet = colors.bright_red,
	String = colors.green,
	Struct = colors.purple,
	Text = colors.light_grey,
	TypeParameter = colors.bright_red,
	Unit = colors.green,
	Value = colors.orange,
	Variable = colors.purple,
}

-- define cmp and aerial kind highlights with lsp_kind_icons_color
for kind, color in pairs(lsp_kind_icons_color) do
	hl.plugins.cmp["CmpItemKind" .. kind] = { fg = color, fmt = cfg.cmp_itemkind_reverse and "reverse" }
	hl.plugins.blink["BlinkCmpKind" .. kind] = { fg = color }
	hl.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
	hl.plugins.navic["NavicIcons" .. kind] = { fg = color }
end

--local function set_highlights(groups)
--  for group, opts in pairs(groups) do
--    vim.api.nvim_set_hl(0, group, opts)
--  end
--end

local function vim_highlights(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
				group_name,
				group_settings.fg or "none",
				group_settings.bg or "none",
				group_settings.sp or "none",
				group_settings.fmt or "none"
			)
		)
	end
end

vim_highlights(hl.statusline)
vim_highlights(hl.common)
vim_highlights(hl.syntax)
vim_highlights(hl.treesitter)

if hl.lsp then
	vim_highlights(hl.lsp)
end
for _, group in pairs(hl.langs) do
	vim_highlights(group)
end
for _, group in pairs(hl.plugins) do
	vim_highlights(group)
end
