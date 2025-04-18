lvim.plugins = {
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  -- { 'ray-x/go.nvim' },
  -- { 'ray-x/guihua.lua' },
  { 'voldikss/vim-floaterm' },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  { "zbirenbaum/copilot.lua" },
  { "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
  },
  {
    "sindrets/diffview.nvim",
    requires = 'nvim-lua/plenary.nvim',
    event = "BufRead",
  },
}
