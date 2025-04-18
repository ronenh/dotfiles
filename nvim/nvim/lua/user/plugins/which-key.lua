return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
--
--
-- {
-- 	'folke/which-key.nvim',
-- 	event = "VeryLazy",
-- 	init = function()
-- 		vim.o.timeout = true
-- 		vim.o.timeoutlen = 300
-- 	end,
-- 	config = function(_, opts)
-- 		local wk = require("which-key")
-- 		wk.setup(opts)
-- 		wk.register({
-- 			["g"] = { name = "+goto" },
-- 			["]"] = { name = "+next" },
-- 			["["] = { name = "+prev" },
-- 			["<leader>b"] = { name = "+buffer" },
-- 			["<leader>c"] = { name = "+code" },
-- 			["<leader>d"] = { name = "+diagnostics" },
-- 			["<leader>f"] = { name = "+find" },
-- 			["<leader>g"] = { name = "+git" },
-- 			["<leader>r"] = { name = "+refactor" },
-- 			["<leader>t"] = { name = "+terminal" },
-- 			["<leader>w"] = { name = "+workspace" },
-- 		})
-- 	end,
-- }
