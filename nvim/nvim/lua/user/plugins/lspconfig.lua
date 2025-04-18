local on_attach = function(client, bufnr)
	local keymap = function(mode, keys, func, opts)
		opts.buffer = bufnr
		vim.keymap.set(mode, keys, func, opts)
	end

	keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
	keymap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
	keymap('n', 'gI', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
	keymap('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
	keymap('n', 'gr', vim.lsp.buf.references, { desc = 'List references' })

	-- keymap('n', '<leader>ds', vim.lsp.buf.document_symbol, { desc = 'List document symbols' })
	-- keymap('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { desc = 'List workspace symbols' })

	keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation' })
	keymap('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Show signature' })
	keymap('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature' })

	keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
	keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

	keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
	keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
	keymap('n',
		'<leader>wl',
		function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
		{ desc = 'List workspace folders' }
	)
	vim.keymap.set('n',
		'<leader>gi',
		require('telescope.builtin').lsp_references,
		{ desc = 'Open references in Telescope' }
	)
end

return {
	'neovim/nvim-lspconfig',
	ft = { 'go', 'json', 'lua', 'python', 'yaml', 'java' },
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'hrsh7th/cmp-nvim-lsp',
		'j-hui/fidget.nvim',
	},
	opts = {
		servers = {
			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						gofumpt = true,
						staticcheck = true,
					},
				},
				on_attach = function(_, bufnr)
					vim.b[bufnr].autoimport = true
				end,
			},
			helm_ls = {
				settings = {
					helm_ls = {
						yamlLanguageServer = {
							path = 'yaml-language-server',
						},
					},
				},
			},
			jsonls = {
				settings = {
					jsonls = {}
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			},
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							-- formatter options
							black = { enabled = true },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							-- linter options
							pylint = { enabled = true, executable = "pylint" },
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							-- type checker
							pylsp_mypy = {
								enabled = true,
								dmypy = true,
								-- overrides = { "--python-executable", py_path(), true },
							},
							-- auto-completion options
							jedi_completion = { fuzzy = true },
							-- import sorting
							pyls_isort = { enabled = true },
						},
					}
				},
			},
			jdtls = {
				settings = {
					java = {
						configuration = {
							runtimes = {
								{
									name = 'Java-22',
									path = '/Library/Java/JavaVirtualMachines/jdk-22.0.2.jdk',
									default = true,
								},
							}
						}
					}
				}
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require('lspconfig');
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		for name, conf in pairs(opts.servers) do
			local attach_cb = on_attach

			if conf.on_attach then
				attach_cb = function(client, bufnr)
					on_attach(client, bufnr)
					conf.on_attach(client, bufnr)
				end
			end

			lspconfig[name].setup {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					local _, err = pcall(attach_cb, client, bufnr)
					if err then
						vim.notify('[on_attach] error: ' .. err, vim.log.levels.ERROR)
					else
						vim.notify('[on_attach] ' .. client.name .. ' attached to buffer ' .. bufnr, vim.log.levels.INFO)
					end
				end,
				settings = conf.settings,
			}
		end
	end
}
