return {
  {
    -- 'ray-x/go.nvim',
    "ray-x/go.nvim",
    -- branch = 'golangci-lint-v2',
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
    },
    init = function()
      vim.cmd(
        [[command! GoLintEx :setl makeprg=.ext/bin/golangci-lint\ run\ --output.text.print-issued-lines=false\ --show-stats=false | :GoMake]]
      )
    end,
    opts = {
      icons = { breakpoint = "🛑", currentpos = "" },
      lsp_gofumpt = true,
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = false,
                rangeVariableTypes = true,
              },
            },
          },
        },
      },
      setup = {
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          LazyVim.lsp.on_attach(function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end, "gopls")
          -- end workaround
        end,
      },
    },
  },
}
