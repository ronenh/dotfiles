return {
	'nvim-telescope/telescope.nvim',
	cmd = 'Telescope',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	keys = function()
		local lazy_telescope = function(builtin)
			return function(...)
				require('telescope.builtin')[builtin](...)
			end
		end
		return {
			{ '<leader>fb', lazy_telescope('buffers'),     desc = 'Find buffers' },
			{ '<leader>fd', lazy_telescope('diagnostics'), desc = 'Find diagnostics' },
			{ '<leader>ff', lazy_telescope('git_files'),   desc = 'Find Git files' },
			{ '<leader>fF', lazy_telescope('find_files'),  desc = 'Find files' },
			{ '<leader>fg', lazy_telescope('live_grep'),   desc = 'Find files by content' },
			{ '<leader>fh', lazy_telescope('help_tags'),   desc = 'Find help tags' },
			{ '<leader>fo', lazy_telescope('oldfiles'),    desc = 'Find recently opened files' },
			{ '<leader>fw', lazy_telescope('grep_string'), desc = 'Find word in buffer' },
			{
				'<leader>f/',
				function()
					lazy_telescope('current_buffer_fuzzy_find')(require('telescope.themes').get_dropdown {
						previewer = false,
					})
				end,
				desc = 'Find fuzzy match in current buffer'
			},
			{ 'gd',         lazy_telescope('lsp_definitions'),       desc = 'Go to definition' },
			{ 'gr',         lazy_telescope('lsp_references'),        desc = 'Go to references' },
			{ 'gy',         lazy_telescope('lsp_type_definitions'),  desc = 'Go to type definition' },
			{ '<leader>fs', lazy_telescope('lsp_document_symbols'),  desc = 'Find document symbols' },
			{ '<leader>fS', lazy_telescope('lsp_workspace_symbols'), desc = 'Find workspace symbols' },
		}
	end,
	opts = function()
		local actions = require('telescope.actions')
		return {
			defaults = {
				mappings = {
					i = {
						['<C-n>'] = actions.cycle_history_next,
						['<C-p>'] = actions.cycle_history_prev,
						['<C-j>'] = actions.move_selection_next,
						['<C-k>'] = actions.move_selection_previous,
					},
					n = { ['q'] = actions.close },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = 'smart_case',
				}
			},
		}
	end,
	config = function(_, opts)
		local telescope = require('telescope')
		telescope.setup(opts)
		telescope.load_extension('fzf')
	end,
}
