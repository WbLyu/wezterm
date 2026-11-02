local platform = require('utils.platform')()

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   -- 使用系统自带的 Windows PowerShell，避免在配置加载时探测命令而产生闪窗。
   options.default_prog = { 'powershell' }
   options.launch_menu = {
      { label = 'WSL Ubuntu（已安装时可用）',domain = { DomainName = 'WSL:Ubuntu' }, cwd = '/home/lwb',},
      { label = 'PowerShell 7（已安装时可用）', args = { 'pwsh' }, domain = { DomainName = 'local' }, },
      { label = 'Windows PowerShell 5.1（兼容模式）', args = { 'powershell' }, domain = { DomainName = 'local' }, },
      { label = 'Git Bash（已安装并加入 PATH 时可用）', args = { 'bash', '-l' }, domain = { DomainName = 'local' }, },
      { label = 'CMD', args = { 'cmd' }, domain = { DomainName = 'local' }, },
   }
elseif platform.is_mac then
   -- Zsh 是现代 macOS 的系统默认 shell；其他 shell 作为可选项。
   options.default_prog = { 'zsh', '-l' }
   options.launch_menu = {
      { label = 'Zsh', args = { 'zsh', '-l' } },
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish（已安装时可用）', args = { 'fish', '-l' } },
      { label = 'Nushell（已安装时可用）', args = { 'nu', '-l' } },
   }
elseif platform.is_linux then
   -- Bash 是 Linux 上最普遍可用的 shell；其他 shell 作为可选项。
   options.default_prog = { 'bash', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Zsh（已安装时可用）', args = { 'zsh', '-l' } },
      { label = 'Fish（已安装时可用）', args = { 'fish', '-l' } },
   }
end

return options
