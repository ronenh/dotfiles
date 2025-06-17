-- Switch to absolute line numbers in edit mode
vim.api.nvim_create_autocmd('InsertEnter', {
	pattern = '*',
	callback = function()
		vim.opt.relativenumber = false
	end
})

-- Switch to relative line numbers in normal mode
vim.api.nvim_create_autocmd('InsertLeave', {
	pattern = '*',
	callback = function()
		vim.opt.relativenumber = true
	end
})

-- Enable autoimport for Go files
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('go', { clear = true }),
	pattern = { 'go' },
	callback = function(args)
		vim.b[args.buf].autoimport = true
	end,
})
