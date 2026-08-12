local Config = require('config')
local has_domains, domains = pcall(require, 'config.domains')
local has_local, local_config = pcall(require, 'config.local')
local launch = require('config.launch')
if has_local then
   for key, value in pairs(local_config) do
      launch[key] = value
   end
end

require('utils.backdrops'):set_files():random()

require('events.right-status').setup()
require('events.left-status').setup()
require('events.tab-title').setup()
require('events.new-tab-button').setup()

local wezterm = require 'wezterm'
local mux = wezterm.mux
wezterm.on('gui-attached', function(_)
  -- maximize all displayed windows on startup
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

local config = Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(has_domains and domains or {})
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(launch)

return config.options
