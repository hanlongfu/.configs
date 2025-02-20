local wezterm = require("wezterm")
local config = {}

-- font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 13

--window
config.window_background_opacity = 0.95
config.macos_window_background_blur = 35
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE|MACOS_FORCE_DISABLE_SHADOW"
config.integrated_title_button_style = "MacOsNative"
config.initial_cols = 130
config.initial_rows = 60
config.window_close_confirmation = "NeverPrompt"
config.native_macos_fullscreen_mode = true
config.window_padding = {
	top = 50,
	right = 10,
	left = 10,
	bottom = 0,
}
-- tab
config.use_fancy_tab_bar = false
config.enable_tab_bar = false

config.colors = {
	tab_bar = {
		background = "rgba(22,24,34,0.95)",
	},
}
config.color_scheme = "iceberg-dark"
return config
