return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "auto", -- auto, main, moon, or dawn
      dark_variant = "moon", -- main, moon, or dawn
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = true, -- enable compiling the colorscheme for faster startup
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      theme = "wave", -- Load "wave" theme
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Make the horizontal/vertical split lines stand out clearly
          WinSeparator = { fg = colors.palette.boatYellow2, bold = true },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "rose-pine",
      colorscheme = "kanagawa",
    },
  },
}
