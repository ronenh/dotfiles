return {
  -- Use (neo)vim terminal in the floating/popup window.
  "voldikss/vim-floaterm",
  keys = {
    { "<leader>tt", ":FloatermToggle<CR>", desc = "Toggle Terminal" },
    { "<leader>tn", ":FloatermNew<CR>", desc = "New Terminal" },
    { "<leader>tj", ":FloatermPrev<CR>", desc = "Previous Terminal" },
    { "<leader>tk", ":FloatermNext<CR>", desc = "Next Terminal" },
  },
  config = function()
    vim.g.floaterm_width = 0.75
    vim.g.floaterm_height = 0.8

    local wk = require("which-key")

    wk.add({
      { "<leader>t", group = "Terminal" },
    })
  end,
}
