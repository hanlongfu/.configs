local wezterm = require("wezterm")
local config = {}

-- font
config.font = wezterm.font("NotoSansM Nerd Font Mono")
config.font_size = 15

--window
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
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

-- color
config.colors = {
	background = "#011423",
	cursor_bg = "#84acfd",
	cursor_border = "#84acfd",
	cursor_fg = "#011423",
	selection_bg = "#0059A2",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#84acfd", "#FFE073", "#30a1ba", "#a277ff", "#4db3b1", "#4db3b1" },
	brights = { "#214969", "#E52E2E", "#84acfd", "#FFE073", "#A277FF", "#a277ff", "#4db3b1", "#4db3b1" },

	compose_cursor = "#e3d18a",
	visual_bell = "#e3d18a",
	-- tab
	tab_bar = {
		background = "rgba(1,20, 35, 0.95)",
	},
}
return config
