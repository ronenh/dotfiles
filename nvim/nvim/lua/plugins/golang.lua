return {
  {
    "ray-x/go.nvim",
    branch = "treesitter-main",
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
    keys = {
      { "<leader>ctf", ":GoTestFunc<CR>", desc = "Run test function", ft = "go" },
      { "<leader>ctF", ":GoTestFunc<CR>", desc = "Run all tests in file", ft = "go" },
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       gopls = {
  --         settings = {
  --           gopls = {
  --             buildFlags = { "-tags=integration" },
  --             workspaceFiles = {
  --               "**/BUILD",
  --               "**/WORKSPACE",
  --               "**/*.{bzl,bazel}",
  --             },
  --             env = {
  --               GOPACKAGESDRIVER = "./scripts/gopackagesdriver.sh",
  --             },
  --             directoryFilters = {
  --               "-",
  --               "+cmd",
  --               "+pkg",
  --             },
  --             hints = {
  --               assignVariableTypes = true,
  --               compositeLiteralFields = true,
  --               compositeLiteralTypes = true,
  --               constantValues = true,
  --               functionTypeParameters = true,
  --               parameterNames = false,
  --               rangeVariableTypes = true,
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
