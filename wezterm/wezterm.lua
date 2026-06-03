-- WezTerm configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- =============================================================================
-- Appearance
-- =============================================================================
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14.0
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- Hide tab bar when only one tab
config.hide_tab_bar_if_only_one_tab = true

-- Allow Option key to produce special characters (e.g., ~ with Opt+N on German keyboard)
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

-- =============================================================================
-- Keybindings
-- =============================================================================
config.keys = {
	-- Split pane horizontally (like iTerm2/Ghostty cmd+d)
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Split pane vertically (like iTerm2/Ghostty cmd+shift+d)
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Close current pane (cmd+w)
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- Navigate between panes (arrow keys)
	{
		key = "LeftArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- Navigate between panes (vim motions)
	{
		key = "h",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CMD|OPT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- Toggle pane zoom (maximize/restore active pane)
	{
		key = "Enter",
		mods = "CMD|SHIFT",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- Rename current tab
	{
		key = "r",
		mods = "CMD|OPT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

return config
