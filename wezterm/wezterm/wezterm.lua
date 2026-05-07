-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 180
config.initial_rows = 60

-- or, changing the font size and color scheme.
config.font = wezterm.font("Hack")
config.font_size = 13
config.color_scheme = "Rosé Pine Moon (Gogh)"

-- Finally, return the configuration to wezterm:
return config
