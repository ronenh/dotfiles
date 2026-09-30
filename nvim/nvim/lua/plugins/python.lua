-- Prefer the project's own ruff over Mason's.
--
-- Repos that pin `required-version` in ruff.toml (e.g. forge/pyforge) make any
-- other ruff version refuse to load the config, and the ruff language server
-- then silently falls back to its defaults (88 cols, default import order).
-- Walk up from the LSP root for a project-local executable in `.venv/bin`.
-- This also finds shared environments at a parent uv workspace root.
local function find_project_executable(root_dir, executable)
  local venv = vim.fs.find(function(name, path)
    return name == ".venv" and vim.fn.executable(path .. "/.venv/bin/" .. executable) == 1
  end, { path = root_dir, upward = true, type = "directory", limit = 1 })[1]
  return venv and (venv .. "/bin/" .. executable) or nil
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          -- Resolve imports from the project environment even when a GUI starts
          -- Neovim without an activated virtualenv. Keep normal discovery if absent.
          before_init = function(_, config)
            local python = find_project_executable(config.root_dir or vim.uv.cwd(), "python")
            if python then
              config.settings = config.settings or {}
              config.settings.python = config.settings.python or {}
              config.settings.python.pythonPath = python
            end
          end,
        },
        ruff = {
          cmd = function(dispatchers, config)
            local bin = find_project_executable(config.root_dir or vim.uv.cwd(), "ruff") or "ruff"
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
