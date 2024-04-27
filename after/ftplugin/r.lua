vim.g.slime_cell_delimiter = "# %%"
vim.api.nvim_set_keymap("n", "<Leader>a", ':execute "normal \\<Plug>SlimeLineSend"<CR>j', {noremap = true})
vim.api.nvim_set_keymap("v", "<Leader>s", "<Plug>SlimeRegionSend", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<Leader>s",
    ':execute "normal \\<Plug>SlimeSendCell"<CR>/' .. vim.g.slime_cell_delimiter .. "<CR>:nohlsearch<CR>",
    {noremap = true}
)
