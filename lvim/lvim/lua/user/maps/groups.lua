local M = {}

M.terminal = {
  name = "Terminal",
  t = { ":FloatermToggle<CR>", "Toggle Terminal" },
  n = { ":FloatermNew<CR>", "New Terminal" },
  j = { ":FloatermPrev<CR>", "Previous Terminal" },
  k = { ":FloatermNext<CR>", "Next Terminal" },
}

return M
