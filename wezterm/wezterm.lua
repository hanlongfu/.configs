local wezterm = require("wezterm")
local config = {}

-- font
config.font = wezterm.font("MesloLGM Nerd Font Mono")
config.font_size = 14

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
	background = "#011627",
	foreground = "#bdc1c6",
	cursor_bg = "#30a1ba",
	cursor_fg = "#080808",
	cursor_border = "#9ca1aa",
	selection_bg = "#b2ceee",
	selection_fg = "#080808",
	scrollbar_thumb = "#9ca1aa",
	split = "#9ca1aa",

	ansi = {
		"#1d3b53",
		"#fc514e",
		"#a1cd5e",
		"#e3d18a",
		"#82aaff",
		"#c792ea",
		"#7fdbca",
		"#a1aab8",
	},
	brights = {
		"#7c8f8f",
		"#ff5874",
		"#21c7a8",
		"#ecc48d",
		"#82aaff",
		"#ae81ff",
		"#7fdbca",
		"#d6deeb",
	},

	compose_cursor = "#e3d18a",
	visual_bell = "#e3d18a",

	-- tab
	tab_bar = {
		background = "rgba(1,20, 35, 0.95)",
	},
}
return config
