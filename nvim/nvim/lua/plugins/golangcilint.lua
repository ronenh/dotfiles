-- golangci-lint's typecheck pass needs to compile the whole package, but the
-- stock nvim-lint definition falls back to single-file mode when nvim's cwd is
-- outside a Go module (`go env GOMOD` is /dev/null there — a go.work at the cwd
-- doesn't count). Linting one file makes every symbol defined in sibling files
-- report as "undefined: ..." (typecheck). Override the linter to always lint the
-- buffer's directory and to run golangci-lint from that directory, so the module
-- and .golangci.yaml are resolved no matter where nvim was opened.
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        golangcilint = function()
          local base = require("lint.linters.golangcilint")
          local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          -- The last arg in every variant of the stock definition is the lint
          -- target (file or dir, decided at startup); force it to the dir.
          local args = vim.list_extend({}, base.args or {})
          args[#args] = dir
          return vim.tbl_extend("force", base, { cwd = dir, args = args })
        end,
      },
    },
  },
}
