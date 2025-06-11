----- Options -----

-- security
--vim.opt.modelines = 0

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

-- What to save for views and sessions
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.sessionoptions:remove({ 'blank', 'buffers', 'terminal' })
vim.opt.sessionoptions:append({ 'globals', 'skiprtp' })


----- Timing -----

vim.opt.ttimeout = true

-- Save swap file and trigger CursorHold
vim.opt.updatetime = 200

-- Lower than default (1000) to quickly trigger which-key
vim.opt.timeoutlen = 300

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

-- Adjust match case
vim.opt.infercase = true

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
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  - "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments when joining lines, if possible.
  - "2" -- I'm not in gradeschool anymore

-- Fuzzy find.
vim.opt.path:append("**")

-- Ignore files vim doesn't use.
vim.opt.wildignore:append(".git,.hg,.svn")
vim.opt.wildignore:append(".aux,*.out,*.toc")
vim.opt.wildignore:append(".o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class")
vim.opt.wildignore:append(".ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp")
vim.opt.wildignore:append(".avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg")
vim.opt.wildignore:append(".mp3,*.oga,*.ogg,*.wav,*.flac")
vim.opt.wildignore:append(".eot,*.otf,*.ttf,*.woff")
vim.opt.wildignore:append(".doc,*.pdf,*.cbr,*.cbz")
vim.opt.wildignore:append(".zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb")
vim.opt.wildignore:append(".swp,.lock,.DS_Store,._*")
vim.opt.wildignore:append(".,..")

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

-- Command-line completion mode
vim.opt.wildmode = "longest:full,full"
vim.opt.wildmenu = true
vim.opt.wildignorecase = true


----- UI -----

-- True color support.
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

-- Message opts
vim.opt.shortmess:append({
  W = true,
  I = true,
  c = true,
  --w = true,
  s = true,
})

-- always show tabs
vim.opt.showtabline = 0

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

-- Whitespace
vim.opt.showbreak = "↳ "

-- UI icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
vim.opt.listchars = {
	eol = " ",
	tab = "╎ ",
	--extends = "⟫",
	--precedes = "⟪",
	nbsp = "␣",
	trail = "_",
}

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

-- If sudo, disable vim swap/backup/undo/shada writing
local USER = vim.env.USER or ""
local SUDO_USER = vim.env.SUDO_USER or ""
if
	SUDO_USER ~= ""
	and USER ~= SUDO_USER
	and vim.env.HOME ~= vim.fn.expand("~" .. USER, true)
	and vim.env.HOME == vim.fn.expand("~" .. SUDO_USER, true)
then
	vim.opt_global.modeline = false
	vim.opt_global.undofile = false
	vim.opt_global.swapfile = false
	vim.opt_global.backup = false
	vim.opt_global.writebackup = false
	vim.opt_global.shadafile = "NONE"
end

-- vim: set ts=2 sw=0 tw=80 noet :
