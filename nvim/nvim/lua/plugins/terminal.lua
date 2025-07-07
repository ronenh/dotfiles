return {
  -- Use (neo)vim terminal in the floating/popup window.
  "voldikss/vim-floaterm",
  keys = {
    { "<leader>tt", ":FloatermToggle<CR>", "Toggle Terminal" },
    { "<leader>tn", ":FloatermNew<CR>", "New Terminal" },
    { "<leader>tj", ":FloatermPrev<CR>", "Previous Terminal" },
    { "<leader>tk", ":FloatermNext<CR>", "Next Terminal" },
  },
  config = function()
    vim.g.floaterm_width = 0.75
    vim.g.floaterm_height = 0.8
  end,
}
