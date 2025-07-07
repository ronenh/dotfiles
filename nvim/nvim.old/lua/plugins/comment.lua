return {
	-- Smart and Powerful commenting plugin for neovim
	'numToStr/Comment.nvim',
	opts = {
		toggler = {
			---Line-comment toggle keymap
			line = '<leader>cc',
			---Block-comment toggle keymap
			block = '<leader>cb',
		},
		---LHS of operator-pending mappings in NORMAL and VISUAL mode
		opleader = {
			---Line-comment keymap
			line = 'gc',
			---Block-comment keymap
			block = 'gb',
		},
		---LHS of extra mappings
		extra = {
			---Add comment on the line above
			above = 'gcO',
			---Add comment on the line below
			below = 'gco',
			---Add comment at the end of line
			eol = 'gcA',
		},
	}
}
