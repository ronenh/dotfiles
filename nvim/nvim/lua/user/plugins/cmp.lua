return {
	'hrsh7th/nvim-cmp',
	event = { 'InsertEnter', 'CmdlineEnter' },
	dependencies = {
		'hrsh7th/cmp-buffer',
		-- 'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-path',
		"onsails/lspkind.nvim", -- vs-code like pictograms
		'saadparwaiz1/cmp_luasnip',
	},
	opts = function()
		local cmp = require('cmp')
		local lspkind = require("lspkind")

		return {
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			-- mapping = cmp.mapping.preset.insert(),
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'copilot',  group_index = 2 },
				{ name = 'nvim_lsp', group_index = 2 },
				{ name = 'luasnip',  group_index = 2 },
				{ name = 'buffer',   group_index = 2 },
				{ name = 'path',     group_index = 2 },
			}),
			sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,

					-- Below is the default comparitor list and order for nvim-cmp
					cmp.config.compare.offset,
					-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			view = {
				entries = { name = 'custom', selection_order = 'near_cursor' }
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					menu = ({
						buffer = "[Buffer]",
						copilot = "[Copilot]",
						luasnip = "[LuaSnip]",
						nvim_lsp = "[LSP]",
						path = "[Path]",
					}),
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 100, -- leading text (labelDetails)
						abbr = 100, -- actual suggestion item
					},
					ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
					symbol_map = { Copilot = "" }
				})
			}
		}
	end,
}
