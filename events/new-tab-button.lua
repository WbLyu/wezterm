local wezterm = require('wezterm')
local nf = wezterm.nerdfonts
local act = wezterm.action

local M = {}

M.setup = function()
   wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
      wezterm.log_info('new-tab', window, pane, button, default_action)

      -- 左键：Windows 下默认打开 WSL Ubuntu
      if button == 'Left' and wezterm.target_triple:find('windows') then
         window:perform_action(
            act.SpawnCommandInNewTab {
               domain = { DomainName = 'WSL:Ubuntu' },
               cwd = '/home/lwb',
            },
            pane
         )
         return false
      end

      -- 右键：打开自定义 Launcher
      if button == 'Right' then
         window:perform_action(
            act.ShowLauncherArgs {
               title = nf.fa_rocket .. '  Select/Search:',
               flags = 'FUZZY|LAUNCH_MENU_ITEMS|DOMAINS',
            },
            pane
         )
         return false
      end

      -- 其他情况使用 WezTerm 默认行为
   end)
end

return M