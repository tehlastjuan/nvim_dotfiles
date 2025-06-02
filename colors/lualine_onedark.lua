local colors = require("custom_onedark").colors
local line_colors = {
    bg     = colors.bg0,
    fg     = colors.fg,
    red    = colors.red,
    green  = colors.green,
    yellow = colors.yellow,
    blue   = colors.blue,
    purple = colors.purple,
    cyan   = colors.cyan,
    gray   = colors.grey
}

local one_dark = {
    inactive = {
        a = {fg = line_colors.gray, bg = line_colors.bg, gui = 'bold'},
        b = {fg = line_colors.gray, bg = line_colors.bg},
        c = {fg = line_colors.gray, bg = none},
    },
    normal = {
        a = {fg = line_colors.bg, bg = line_colors.green, gui = 'bold'},
        b = {fg = line_colors.fg, bg = colors.bg3},
        c = {fg = line_colors.fg, bg = none},
    },
    visual = {a = {fg = line_colors.bg, bg = line_colors.purple, gui = 'bold'}},
    replace = {a = {fg = line_colors.bg, bg = line_colors.red, gui = 'bold'}},
    insert = {a = {fg = line_colors.bg, bg = line_colors.blue, gui = 'bold'}},
    command = {a = {fg = line_colors.bg, bg = line_colors.yellow, gui = 'bold'}},
    terminal = {a = {fg = line_colors.bg, bg = line_colors.cyan, gui = 'bold'}},
}
return one_dark;
