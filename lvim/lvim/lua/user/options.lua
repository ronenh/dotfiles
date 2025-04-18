vim.opt.relativenumber = true
vim.opt.timeoutlen = 100
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 14
vim.opt.scrolloff = 12
vim.opt.sidescrolloff = 24
vim.opt.cursorline = true -- highlight the current line

-- Lvim
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "lunar"
lvim.transparent_window = false

-- Builtins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- lvim.builtin.terminal.active = false

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "go",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "ruby",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- Disable lir
-- lvim.builtin.lir.active = false
