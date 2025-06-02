
-- Exit insert mode
vim.keymap.set("i", "jk", "<ESC>", { desc = "ESC" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "ESC" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set({ "n", "t" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set({ "n", "t" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set({ "n", "t" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set({ "n", "t" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffers
vim.keymap.set("n", "<c-,>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<c-.>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search with <esc>
vim.keymap.set({ "i", "s", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape, clear hlsearch" })

--vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
--  if require("luasnip").expand_or_jumpable() then
--    require("luasnip").unlink_current()
--  end
--  vim.cmd "noh"
--  return "<esc>"
--end, { desc = "Escape, clear hlsearch, stop snippets session" })

-- Clear search, diff update and redraw, taken from runtime/lua/_editor.lua
--vim.keymap.set( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Keyword prg
vim.keymap.set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- Plugin manager
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { expr = true, silent = true, desc = "Lazy" })

-- Formatting
vim.keymap.set({ "n", "v" }, "<leader>cf", "mzgggqG`z<cmd>delmarks z<cr>zz", { desc = "Format" })
-- vim.keymap.set({ "n", "v" }, "<leader>cf", function() LazyVim.format({ force = true }) end, { desc = "Format" })

-- Close all buffers and quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Highlights under cursor
vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
vim.keymap.set("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Web-tools
vim.keymap.set("n", "<leader>cb", "<cmd>BrowserOpen<cr>", { desc = "Browser Preview", remap = true })

-- Toggleterm
vim.keymap.set({ "n" }, "<c-/>", "<cmd>ToggleTerm<cr>", { desc = "Toggleterm", })
vim.keymap.set({ "n" }, "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggleterm float", })
vim.keymap.set({ "n" }, "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", { desc = "Toggleterm horizontal split", })
vim.keymap.set({ "n" }, "<leader>tv", "<cmd>ToggleTerm size=65 direction=vertical<cr>", { desc = "Toggleterm vertical split", })

vim.keymap.set("n", "<leader>ts", function()
  require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
end, { desc = "Send selection to Terminal" })

vim.keymap.set("v", "<leader>tsv", function()
  require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
end, { desc = "Send visual lines to Terminal" })

vim.keymap.set("v", "<leader>tss", function()
  require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
end, { desc = "Send visual selection to Terminal" })

-- Location jumps
vim.keymap.set("n", "<leader>jl", "<cmd>lopen<cr>", { desc = "Location List" })

-- Quickfix jumps
vim.keymap.set("n", "<leader>jq", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", "<leader>jd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>wl", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>wh", "<C-W>v", { desc = "Split window right", remap = true })

-- TODO: Lazygit
-- vim.keymap.set("n", "<leader>gg", function() LazyVim.terminal({ "lazygit" }, { cwd = LazyVim.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- vim.keymap.set("n", "<leader>gG", function() LazyVim.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })
-- vim.keymap.set("n", "<leader>gb", LazyVim.lazygit.blame_line, { desc = "Git Blame Line" })
-- vim.keymap.set("n", "<leader>gB", LazyVim.lazygit.browse, { desc = "Git Browse" })
--
-- vim.keymap.set("n", "<leader>gf", function()
--   local git_path = vim.api.nvim_buf_get_name(0)
--   LazyVim.lazygit({args = { "-f", vim.trim(git_path) }})
-- end, { desc = "Lazygit Current File History" })
--
-- vim.keymap.set("n", "<leader>gl", function()
--   LazyVim.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
-- end, { desc = "Lazygit Log" })
--
-- vim.keymap.set("n", "<leader>gL", function()
--   LazyVim.lazygit({ args = { "log" } })
-- end, { desc = "Lazygit Log (cwd)" })

-- Easy mode
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Up>", "<Nop>", { desc = "no up for you" })
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Left>", "<Nop>", { desc = "no up for you" })
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Right>", "<Nop>", { desc = "no up for you" })
vim.keymap.set({ "n", "i", "x", "v", "x", "o" }, "<Down>", "<Nop>", { desc = "no up for you" })

-- Window debug
vim.keymap.set("n", "<leader>ux", function()
  print (vim.inspect(vim.api.nvim_get_current_win()))
end, { desc = "Get current window" })

vim.keymap.set("n", "<leader>uy", function()
  print (vim.inspect(vim.api.nvim_list_bufs()))
end, { desc = "List buffers" })

vim.keymap.set("n", "<leader>uz", function()
  print (vim.inspect(vim.api.nvim_list_wins()))
end, { desc = "List windows" })

-- END --













-- Move Lines
-- vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
-- vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
-- vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
-- vim.keymap.set("i", ",", ",<c-g>u")
-- vim.keymap.set("i", ".", ".<c-g>u")
-- vim.keymap.set("i", ";", ";<c-g>u")

-- save file
-- vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- new file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- stylua: ignore start

-- toggle options
-- LazyVim.toggle.map("<leader>uf", LazyVim.toggle.format())
-- LazyVim.toggle.map("<leader>uF", LazyVim.toggle.format(true))
-- LazyVim.toggle.map("<leader>us", LazyVim.toggle("spell", { name = "Spelling" }))
-- LazyVim.toggle.map("<leader>uw", LazyVim.toggle("wrap", { name = "Wrap" }))
-- LazyVim.toggle.map("<leader>uL", LazyVim.toggle("relativenumber", { name = "Relative Number" }))
-- LazyVim.toggle.map("<leader>ud", LazyVim.toggle.diagnostics)
-- LazyVim.toggle.map("<leader>ul", LazyVim.toggle.number)
-- LazyVim.toggle.map( "<leader>uc", LazyVim.toggle("conceallevel", { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } }))
-- LazyVim.toggle.map("<leader>uT", LazyVim.toggle.treesitter)
-- LazyVim.toggle.map("<leader>ub", LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" }))
-- if vim.lsp.inlay_hint then
--   LazyVim.toggle.map("<leader>uh", LazyVim.toggle.inlay_hints)
-- end

-- LazyVim Changelog
-- map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
-- local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
-- map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<leader>fT", function() LazyVim.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<leader>fT", function() LazyVim.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (cwd)" })
-- map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
-- map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- vim.keymap.set("n", "<leader>wm", function() LazyVim.toggle.maximize() end, { desc = "Maximize Toggle" })
-- vim.keymap.set("n", "<leader>m", function() LazyVim.toggle.maximize() end, { desc = "Maximize Toggle" })

-- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
