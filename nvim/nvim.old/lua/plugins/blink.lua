return {
	-- Performant, batteries-included completion plugin for Neovim
	'saghen/blink.cmp',

	dependencies = {
		'fang2hou/blink-copilot',
		'rafamadriz/friendly-snippets',
		'xzbdmw/colorful-menu.nvim',
	},

	-- use a release tag to download pre-built binaries
	version = '1.*',

	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = 'default' },

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		completion = {
			-- (Default) Only show the documentation popup when manually triggered
			documentation = { auto_show = false },

			menu = {
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							width = { fill = true, max = 120 },
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
					treesitter = { 'lsp' },
				},
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
			providers = {
				copilot = {
					name = 'copilot',
					module = 'blink-copilot',
					score_offset = 100,
					async = true,
				},
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = 'lua'` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = 'prefer_rust'`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = 'prefer_rust_with_warning' },
	},
	opts_extend = { 'sources.default' }
}
