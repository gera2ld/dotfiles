local wezterm = require 'wezterm';

local config = {
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = 'Tokyo Night',
  font = wezterm.font('Cascadia Code PL'),
  leader = { key = ']', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = {
    {
      key = '%',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal,
    },
    {
      key = '"',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitVertical,
    },
    {
      key = 'x',
      mods = 'LEADER',
      action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
      key = 'w',
      mods = 'CMD',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = 'LeftArrow',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.MoveTabRelative(-1),
    },
    {
      key = 'RightArrow',
      mods = 'SUPER|SHIFT',
      action = wezterm.action.MoveTabRelative(1),
    },
    {
      key = '9',
      mods = 'LEADER',
      action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
  },
}

return config
