return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			variant = "moon", -- auto, main, moon, or dawn
			dark_variant = "moon", -- main, moon, or dawn
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},

			styles = {
				bold = true,
				italic = true,
				transparency = false,
			},

			groups = {
				border = "muted",
				link = "iris",
				panel = "surface",

				error = "love",
				hint = "iris",
				info = "foam",
				note = "pine",
				todo = "rose",
				warn = "gold",

				git_add = "foam",
				git_change = "rose",
				git_delete = "love",
				git_dirty = "rose",
				git_ignore = "muted",
				git_merge = "iris",
				git_rename = "pine",
				git_stage = "iris",
				git_text = "rose",
				git_untracked = "subtle",

				h1 = "iris",
				h2 = "foam",
				h3 = "rose",
				h4 = "gold",
				h5 = "pine",
				h6 = "foam",
			},

			palette = {
				-- Override the builtin palette per variant
				-- moon = {
				--     base = '#18191a',
				--     overlay = '#363738',
				-- },
			},

			highlight_groups = {
				-- Comment = { fg = "foam" },
				-- VertSplit = { fg = "muted", bg = "muted" },
			},
		},
	}
	-- {
	-- 	'RRethy/base16-nvim',
	-- 	config = function()
	-- 		require('base16-colorscheme').with_config({
	-- 			telescope = true,
	-- 			indentblankline = true,
	-- 			notify = true,
	-- 			ts_rainbow = true,
	-- 			cmp = true,
	-- 			illuminate = true,
	-- 			dapui = true,
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	'rafi/awesome-vim-colorschemes',
	-- },
	-- {
	-- 	'AlexvZyl/nordic.nvim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require('nordic').load()
	-- 	end
	-- }
}
