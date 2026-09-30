-- macOS GUI launches may omit Homebrew from PATH. Append missing directories
-- before plugins load, preserving any inherited virtualenv or tool precedence.
if vim.fn.has("macunix") == 1 then
  local paths = vim.split(vim.env.PATH or "", ":", { trimempty = true })
  for _, path in ipairs({ "/opt/homebrew/bin", "/usr/local/bin" }) do
    if vim.fn.isdirectory(path) == 1 and not vim.tbl_contains(paths, path) then
      paths[#paths + 1] = path
    end
  end
  vim.env.PATH = table.concat(paths, ":")
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
