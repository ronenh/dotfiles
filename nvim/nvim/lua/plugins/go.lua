return {
	-- 'ray-x/go.nvim',
	'ryancragun/go.nvim',
	-- branch = 'golangci-lint-v2',
	dependencies = { -- optional packages
		'ray-x/guihua.lua',
		'neovim/nvim-lspconfig',
		'nvim-treesitter/nvim-treesitter',
		'nvimtools/none-ls.nvim',
	},
	init = function()
		vim.cmd(
			[[command! GoLintEx        :setl makeprg=.ext/bin/golangci-lint\ run\ --output.text.print-issued-lines=false\ --show-stats=false | :GoMake]]
		)
	end,
	opts = {
		icons = { breakpoint = '🛑', currentpos = '' },
		lsp_gofumpt = true,
	},
	event = { 'CmdlineEnter' },
	ft = { 'go', 'gomod' },
	build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
