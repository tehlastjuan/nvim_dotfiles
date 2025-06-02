----- Globals -----

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Enable LazyVim auto format
vim.g.autoformat = false

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "auto"

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
vim.g.lazygit_config = false

-- Options for the LazyVim statuscolumn
vim.g.lazyvim_statuscolumn = {
  folds_open = false, -- show fold sign when fold is open
  folds_githl = false, -- highlight fold sign with git sign color
}

-- Optionally setup the terminal to use
-- This sets `vim.opt.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- LazyVim.terminal.setup("pwsh")

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Show the current document symbols location from Trouble in lualine
vim.g.trouble_lualine = false

-- Disable health checks for python/perl/ruby/node providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.g.yaml_indent_multiline_scalar = 1

vim.g.no_gitrebase_maps = 1 -- See share/nvim/runtime/ftplugin/gitrebase.vim
vim.g.no_man_maps = 1       -- See share/nvim/runtime/ftplugin/man.vim

if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
  vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
else
  vim.opt.foldmethod = "indent"
  vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end


----- General -----

-- the encoding written to a file
vim.opt.fileencoding = "utf-8"

-- Sync with system clipboard
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Enable mouse mode
vim.opt.mouse = "a"

-- Disable horizontal scroll
vim.opt.mousescroll = "ver:3,hor:0"

-- separate vim plugins from neovim in case vim still in use
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

vim.opt.spelllang = { "en" }

-- vim.opt.spelloptions:append('camel')


----- History & Undo -----

vim.opt.history = 5000
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.swapfile = false

-- Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- creates a backup file
vim.opt.backup = false

-- Enable auto write
vim.opt.autowrite = true

-- A file it is not allowed to be edited if is being edited by another program
-- (or was written to file while editing with another program)
vim.opt.writebackup = false


----- Timing -----

vim.opt.ttimeout = true

-- Save swap file and trigger CursorHold
vim.opt.updatetime = 200

-- Lower than default (1000) to quickly trigger which-key
vim.opt.timeoutlen = 500

-- Time out on key codes
vim.opt.ttimeoutlen = 10


----- Tabs & indents -----

-- set max width before wrapping
vim.opt.textwidth = 4

-- Number of spaces tabs count for
vim.opt.tabstop = 2

-- Size of an indent
vim.opt.shiftwidth = 2

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Insert indents automatically
vim.opt.smartindent = false

-- Round indent
vim.opt.shiftround = true


----- Search -----

-- Ignore case
vim.opt.ignorecase = true

-- Don't ignore case with capitals
vim.opt.smartcase = true

-- preview incremental substitute
vim.opt.inccommand = "nosplit"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"


----- Formatting -----

-- Disable line wrap
vim.opt.wrap = false

-- Break long lines at 'breakat'
vim.opt.linebreak = true

-- Long lines break chars
vim.opt.breakat = "\\ \\	;:,!?"

-- Cursor in same column for few commands
vim.opt.startofline = false

-- Put new windows below current
vim.opt.splitbelow = false

-- force all vertical splits to go to the right of current window
vim.opt.splitright = true

-- Default splitting will cause your main splits to jump when opening an edgebar.
vim.opt.splitkeep = "screen"
vim.opt.breakindentopt = { shift = 2, min = 20 }
vim.opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  - "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- Session
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.wildignore:append { ".DS_store" }

-- Command-line completion mode
vim.opt.wildmode = "longest:full,full"




----- UI -----

-- True color support
vim.opt.termguicolors = true

-- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.signcolumn = "yes"

-- Dont show mode since we have a statusline
vim.opt.showmode = false

-- global statusline
vim.opt.laststatus = 3

-- so that `` is visible in markdown file
vim.opt.conceallevel = 0

-- set number column width to 2 {default 4}
vim.opt.numberwidth = 2

-- Keep at least 2 lines above/below
vim.opt.scrolloff = 8

-- Keep at least 5 lines left/right
vim.opt.sidescrolloff = 5

-- Relative line numbers
vim.opt.relativenumber = true

-- Print line number
vim.opt.number = true

-- Disable default status ruler
vim.opt.ruler = false

-- Show some invisible characters (tabs...
vim.opt.list = true

vim.opt.shortmess:append {
  -- w = true,
  -- s = true,
  W = true,
  I = true,
  c = true,
  C = true
}

-- always show tabs
vim.opt.showtabline = 2

-- Disable help window resizing
vim.opt.helpheight = 0

-- Minimum width for active window
vim.opt.winwidth = 30

-- Minimum width for inactive windows
vim.opt.winminwidth = 5

-- Minimum height for active window
vim.opt.winheight = 1

-- Minimum height for inactive window
vim.opt.winminheight = 1

-- Resize windows on split or close
vim.opt.equalalways = true

-- Enable highlighting of the current line
vim.opt.cursorline = false
-- vim.opt.cursorlineopt = { 'line' }

-- Allow cursor to move where there is no text in visual block mode
vim.opt.virtualedit = "block"

-- more space in the neovim command line for displaying messages
vim.opt.cmdheight = 1

-- Command-line lines
vim.opt.cmdwinheight = 5

-- Popup blend
vim.opt.pumblend = 10

-- Maximum number of entries in a popup
vim.opt.pumheight = 10

-- Folding
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.wo.foldtext = ""

-- UI icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
vim.opt.showbreak = "↳  "
-- vim.opt.listchars = {
--   tab = "  ",
--   extends = "⟫",
--   precdes = "⟪",
--   nbsp = "␣",
--   trail = "_",
-- }
vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  foldclose = "󰅂", -- 󰅂 
  foldopen = "󰅀", -- 󰅀 
  foldsep = " ",
  msgsep = "-",
  diff = "╱",
  -- horiz = '━',
  -- horizup = '┻',
  -- horizdown = '┳',
  -- vert = '┃',
  -- vertleft = '┫',
  -- vertright = '┣',
  -- verthoriz = '╋',
}
