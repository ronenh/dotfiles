return {
	'nvim-treesitter/nvim-treesitter',
	ft = { 'c', 'cpp', 'go', 'lua', 'rust' },
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter.configs').setup {
			modules = {},
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				'bash',
				'c',
				'cpp',
				'css',
				'fish',
				'go',
				'graphql',
				'helm',
				'java',
				'javascript',
				'json',
				'lua',
				'markdown',
				'python',
				'ruby',
				'tsx',
				'typescript',
				'vimdoc',
				'vim',
				'yaml',
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = false,

			ignore_install = {},

			highlight = {
				enable = true,
				disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
				additional_vim_regex_highlighting = false,
			},
		}
	end,
}
