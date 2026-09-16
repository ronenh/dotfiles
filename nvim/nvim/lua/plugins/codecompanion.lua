return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {
      interactions = {
        chat = {
          adapter = "claude_code",
        },
        -- Or, just specify the adapter by name
        inline = {
          adapter = "claude_code",
        },
        cli = {
          agent = "claude_code",
          agents = {
            claude_code = {
              cmd = "claude",
              args = {},
              description = "Claude Code CLI",
              provider = "terminal",
            },
          },
        },
        cmd = {
          adapter = "claude_code",
        },
        background = {
          adapter = "claude_code",
        },
      },
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                -- Read the token from the macOS keychain at load time so it never lives in
                -- this file. Store it with:
                --   security add-generic-password -a $USER -s claude-code-oauth -w <token> -U
                CLAUDE_CODE_OAUTH_TOKEN = "cmd:security find-generic-password -w -s claude-code-oauth -a $USER",
              },
            })
          end,
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
