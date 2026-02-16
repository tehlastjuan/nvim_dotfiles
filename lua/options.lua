local icons = require('icons')

----- opts

-- security
--vim.opt.modelines = 0

vim.opt.fileencoding = "utf-8"

-- sync with system clipboard
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- enable mouse mode
vim.opt.mouse = "a"

-- disable horizontal scroll
vim.opt.mousescroll = "ver:3,hor:0"

-- separate vim plugins from neovim in case vim still in use
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

vim.opt.spelllang = { "en" }

-- vim.opt.spelloptions:append('camel')
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"


----- history & undo

vim.opt.history = 5000
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.swapfile = false

-- confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- creates a backup file
vim.opt.backup = false

-- enable auto write
vim.opt.autowrite = true

-- a file it is not allowed to be edited if is being edited by another program
-- (or was written to file while editing with another program)
vim.opt.writebackup = false

-- what to save for views and sessions
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.sessionoptions:remove({ 'blank', 'buffers', 'terminal' })
vim.opt.sessionoptions:append({ 'globals', 'skiprtp' })


----- timing

vim.opt.ttimeout = true

-- Save swap file and trigger CursorHold
vim.opt.updatetime = 200

-- Lower than default (1000) to quickly trigger which-key
vim.opt.timeoutlen = 300

-- Time out on key codes
vim.opt.ttimeoutlen = 10


----- tabs & indents

-- set max width before wrapping
vim.opt.textwidth = 4

-- number of spaces tabs count for
vim.opt.tabstop = 2

-- size of an indent
vim.opt.shiftwidth = 2

-- use spaces instead of tabs
vim.opt.expandtab = true

-- insert indents automatically
vim.opt.smartindent = false

-- round indent
vim.opt.shiftround = true


----- search

-- ignore case
vim.opt.ignorecase = true

-- don't ignore case with capitals
vim.opt.smartcase = true

-- adjust match case
vim.opt.infercase = true

-- preview incremental substitute
vim.opt.inccommand = "nosplit"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"


----- formatting

-- disable line wrap
vim.opt.wrap = false

-- break long lines at 'breakat'
vim.opt.linebreak = true

-- long lines break chars
vim.opt.breakat = "\\ \\	;:,!?"

-- cursor in same column for few commands
vim.opt.startofline = false

-- put new windows below current
vim.opt.splitbelow = false

-- force all vertical splits to go to the right of current window
vim.opt.splitright = true

-- default splitting will cause your main splits to jump when opening an edgebar.
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

-- fuzzy find
vim.opt.path:append("**")

-- ignore files vim doesn't use.
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

-- completion
vim.opt.completeopt = "menu,menuone,noselect"

-- command-line completion mode
vim.opt.wildmode = "longest:full,full"
vim.opt.wildmenu = true
vim.opt.wildignorecase = true


----- ui

-- true color support
vim.opt.termguicolors = true

-- always show the signcolumn, otherwise it would shift the text each time
vim.opt.signcolumn = "yes"

-- don't show mode since we have a statusline
vim.opt.showmode = false

-- global statusline
vim.opt.laststatus = 3

-- so that `` is visible in markdown file
vim.opt.conceallevel = 0

-- set number column width to 2 {default 4}
vim.opt.numberwidth = 2

-- keep at least n lines above/below
vim.opt.scrolloff = 8

-- keep at least n lines left/right
vim.opt.sidescrolloff = 5

-- relative line numbers
vim.opt.relativenumber = true

-- print line number
vim.opt.number = true

-- disable default status ruler
vim.opt.ruler = false

-- show invisible characters (tabs...
vim.opt.list = true

-- diff mode settings
-- (setting the context to a very large number disables folding)
vim.opt.diffopt:append 'vertical,context:99'

-- Message opts
vim.opt.shortmess:append({
  -- W = true,
  -- I = true,
  -- c = true,
  w = true,
  s = true,
})

-- disable show tabs
vim.opt.showtabline = 0

-- disable help window resizing
vim.opt.helpheight = 0

-- minimum width for active window
vim.opt.winwidth = 30

-- minimum width for inactive windows
vim.opt.winminwidth = 5

-- minimum height for active window
vim.opt.winheight = 1

-- minimum height for inactive window
vim.opt.winminheight = 1

-- resize windows on split or close
vim.opt.equalalways = true

-- disble highlighting of the current line
vim.opt.cursorline = false
-- vim.opt.cursorlineopt = { 'line' }

-- allow cursor to move where there is no text in visual block mode
vim.opt.virtualedit = "block"

-- space in the neovim command line for displaying messages
vim.opt.cmdheight = 1

-- command-line lines
vim.opt.cmdwinheight = 5

-- popup blend
vim.opt.pumblend = 10

-- maximum number of entries in a popup
vim.opt.pumheight = 10

-- folding
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.wo.foldtext = ""

-- whitespace
vim.opt.showbreak = "↳ "

-- UI icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
vim.opt.listchars = {
	eol = " ",
	tab = icons.misc.vbar_sp_half, --  "╎ ",
	--extends = "⟫",
	--precedes = "⟪",
	nbsp = "␣",
	trail = "_",
}

vim.opt.fillchars = {
	eob = " ",
	fold = " ",
	foldclose = icons.folds.fold_closed, -- "󰅂", ""
	foldopen = icons.folds.fold_open,    -- "󰅀", ""
	foldsep = " ",
	msgsep = "─",
	-- horiz = '━',
	-- horizup = '┻',
	-- horizdown = '┳',
	-- vert = '┃',
	-- vertleft = '┫',
	-- vertright = '┣',
	-- verthoriz = '╋',
}

-- vim: set ts=2 sw=0 tw=80 noet :
