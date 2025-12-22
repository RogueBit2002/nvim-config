-- TODO: Integrate vim
local vim = vim

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false


vim.o.termguicolors = true

vim.g.mapleader = " "

require("config.lazy")

vim.cmd.colorscheme "sonokai"


vim.lsp.enable "lua_ls"
vim.lsp.enable "ts_ls"
vim.lsp.enable "zlm"


vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_lines = true,
	update_in_insert = true,
})

vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<C-h>', ":wincmd h<CR>")
vim.keymap.set('n', '<C-j>', ":wincmd j<CR>")
vim.keymap.set('n', '<C-k>', ":wincmd k<CR>")
vim.keymap.set('n', '<C-l>', ":wincmd l<CR>")
