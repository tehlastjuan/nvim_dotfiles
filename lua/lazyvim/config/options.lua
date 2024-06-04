-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Enable LazyVim auto format
vim.g.autoformat = false

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- LazyVim automatically configures lazygit:
--  * theme, based on the active colorscheme.
--  * editorPreset to nvim-remote
--  * enables nerd font icons
-- Set to false to disable.
vim.g.lazygit_config = true

-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- LazyVim.terminal.setup("pwsh")

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Show the current document symbols location from Trouble in lualine
vim.g.trouble_lualine = false

local opt = vim.opt

-- General ~~~~
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.mouse = "nv" -- Enable mouse mode

opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
-- opt.spelloptions:append('camel')
opt.spelllang = { "en" }

-- Timing
opt.ttimeout = true
opt.timeoutlen = 300
opt.ttimeoutlen = 10 -- Time out on key codes
opt.updatetime = 200 -- Save swap file and trigger CursorHold

-- History & Undo ~~~~
opt.history = 5000
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.backup = false -- creates a backup file
opt.autowrite = true -- Enable auto write
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- Tabs & indents ~~~~
-- opt.textwidth = 4               -- set max width before wrapping
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = false -- Insert indents automatically
opt.shiftround = true -- Round indent

-- Formatting ~~~~
opt.wrap = false -- Disable line wrap
opt.linebreak = true -- Break long lines at 'breakat'
opt.breakat = "\\ \\	;:,!?" -- Long lines break chars
opt.startofline = false -- Cursor in same column for few commands
opt.splitbelow = false -- Put new windows below current
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.splitkeep = "screen" -- Default splitting will cause your main splits to jump when opening an edgebar.
opt.breakindentopt = { shift = 2, min = 20 }
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  - "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- Session ~~~~
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Search
opt.ignorecase = false -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.inccommand = "nosplit" -- preview incremental substitute
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- UI ~~~~
opt.termguicolors = true -- True color support
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.showmode = false -- Dont show mode since we have a statusline
opt.laststatus = 3 -- global statusline
opt.conceallevel = 0 -- so that `` is visible in markdown file

opt.numberwidth = 2 -- set number column width to 2 {default 4}
opt.scrolloff = 8 -- Keep at least 2 lines above/below
opt.sidescrolloff = 5 -- Keep at least 5 lines left/right
opt.relativenumber = true -- Relative line numbers
opt.number = true -- Print line number
opt.ruler = false -- Disable default status ruler
opt.list = true -- Show some invisible characters (tabs...
opt.shortmess:append({ W = true, I = true, c = true, C = true })

opt.showtabline = 2 -- always show tabs
opt.helpheight = 0 -- Disable help window resizing
opt.winwidth = 30 -- Minimum width for active window
opt.winminwidth = 5 -- Minimum width for inactive windows
opt.winheight = 1 -- Minimum height for active window
opt.winminheight = 1 -- Minimum height for inactive window
opt.equalalways = true -- Resize windows on split or close

-- opt.cursorline = true          -- Enable highlighting of the current line
-- opt.cursorlineopt = { 'line' }
opt.virtualedit = "none" -- Allow cursor to move where there is no text in visual block mode
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.cmdwinheight = 5 -- Command-line lines

opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- Folding ~~~~
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "0"
opt.foldenable = true

-- UI icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
opt.showbreak = "↳  "
opt.listchars = {
  tab = "  ",
  extends = "⟫",
  precedes = "⟪",
  nbsp = "␣",
  trail = "_",
}
opt.fillchars = {
  foldopen = "󰅀", -- 󰅀 
  foldclose = "󰅂", -- 󰅂 
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
  -- horiz = '━',
  -- horizup = '┻',
  -- horizdown = '┳',
  -- vert = '┃',
  -- vertleft = '┫',
  -- vertright = '┣',
  -- verthoriz = '╋',
}
-- opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   -- fold = "⸱",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
else
  opt.foldmethod = "indent"
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
