return {
	-- Lightweight yet powerful formatter plugin for Neovim
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	keys = {
		{
			'<leader>cf',
			function()
				require('conform').format({ async = true, lsp_fallback = true })
			end,
			mode = '',
			desc = 'Format buffer',
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
	init = function()
		local utils = require('user.utils')

		vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'

		vim.api.nvim_create_autocmd('BufWritePre', {
			desc = 'Format on save',
			pattern = '*',
			group = vim.api.nvim_create_augroup('format_on_save', { clear = true }),
			callback = function(args)
				if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= '' then
					return
				end

				if vim.b[args.buf].autoimport == true then
					utils.organizeImports(args.buf)
				end

				if vim.b[args.buf].autoformat ~= false then
					require('conform').format({
						buf = args.buf,
						async = false,
						timeout_ms = 500,
						lsp_fallback = true,
					})
				end
			end,
		})
	end,
}
