-- Prefer the project's own ruff over Mason's.
--
-- Repos that pin `required-version` in ruff.toml (e.g. forge/pyforge) make any
-- other ruff version refuse to load the config, and the ruff language server
-- then silently falls back to its defaults (88 cols, default import order).
-- Walk up from the buffer's directory for a `.venv/bin/ruff` and use it when
-- present; otherwise fall back to whatever `ruff` is on PATH (Mason).
local function find_project_ruff(root_dir)
  local venv = vim.fs.find(function(name, path)
    return name == ".venv" and vim.uv.fs_stat(path .. "/.venv/bin/ruff") ~= nil
  end, { path = root_dir, upward = true, type = "directory", limit = 1 })[1]
  return venv and (venv .. "/bin/ruff") or nil
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd = function(dispatchers, config)
            local bin = find_project_ruff(config.root_dir or vim.uv.cwd()) or "ruff"
            return vim.lsp.rpc.start({ bin, "server" }, dispatchers, {
              cwd = config.root_dir,
              env = config.cmd_env,
            })
          end,
        },
      },
    },
  },
}
