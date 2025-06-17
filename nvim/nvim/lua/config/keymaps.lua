vim.g.mapleader = ',' -- change the <leader> key to be comma

local keymap = vim.keymap

keymap.set('n', '<C-S-n>', function()
	vim.opt.relativenumber = not vim.o.relativenumber
end, {
	desc = "toggle relative/absolute line numbers",
})

-- Move to window using the <C-hjkl> keys
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Switch to left window' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Switch to lower window' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Switch to upper window' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Switch to right window' })

-- Close the currnet buffer and move to the previous one
keymap.set('n', '<leader>z', ':bp<CR>:bd #<CR>', { desc = 'Close the current buffer', silent = true })

keymap.set({ 'n', 'x' }, '<leader>d', '"_d', { desc = 'Delete without yanking to default register' })
keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste default register over selection' })

-- Move blocks of selected lines up and down
-- keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- keymap.set("v", "K", ":m '<-2<CR>gv=gv")
