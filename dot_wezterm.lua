local wezterm = require 'wezterm';

local config = {
  hide_tab_bar_if_only_one_tab = true,
  font = wezterm.font('Cascadia Code PL'),
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
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
    -- Send `c-a` to the terminal when pressing `c-a c-a`
    {
      key = 'a',
      mods = 'LEADER|CTRL',
      action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
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
  },
}

return config
