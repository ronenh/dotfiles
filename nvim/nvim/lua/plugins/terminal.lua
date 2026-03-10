return {
  -- Use (neo)vim terminal in the floating/popup window.
  "voldikss/vim-floaterm",
  keys = {
    { "<leader>rr", ":FloatermToggle<CR>", desc = "Toggle Terminal" },
    { "<leader>rn", ":FloatermNew<CR>", desc = "New Terminal" },
    { "<leader>rj", ":FloatermPrev<CR>", desc = "Previous Terminal" },
    { "<leader>rk", ":FloatermNext<CR>", desc = "Next Terminal" },
  },
  config = function()
    vim.g.floaterm_width = 0.75
    vim.g.floaterm_height = 0.8

    require("which-key").add({
      { "<leader>r", group = "Terminal" },
    })
  end,
}
