return {
	'nvimtools/none-ls.nvim',
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = function()
		local null_ls = require("null-ls")

		return {
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.revive,
				null_ls.builtins.formatting.golines.with({
					extra_args = {
						"--max-len=150",
						"--base-formatter=gofumpt",
					},
				}),
			}
		}
	end,
}
