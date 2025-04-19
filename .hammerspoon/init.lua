-- ln -s ~/dev/dotfiles/.hammerspoon ~/.hammerspoon

hs.alert.show("Loading Hammerspoon...")

hyper = {"cmd", "alt", "ctrl", "shift"}
--hyper = {"esc"}

-- bind reload at start in case of error later in config
hs.hotkey.bind(hyper, "R", hs.reload)
hs.hotkey.bind(hyper, "Y", hs.toggleConsole)

-- helloworld
hs.hotkey.bind(hyper, "W", function()
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)

-- require('control-escape')
require('disable-reload-iterm')

-- log active app (useful for later configs)
hs.application.watcher.new(function(name, event, app)
    if event == hs.application.watcher.activated then
        print("Active App:", name)
    end
end):start()

-- window mgmt
-- hs.hotkey.bind(hyper, "H", function() hs.window.focusedWindow():moveOneScreenWest() end)  -- Move window left
-- hs.hotkey.bind(hyper, "L", function() hs.window.focusedWindow():moveOneScreenEast() end)  -- Move window right
-- hs.hotkey.bind(hyper, "J", function() hs.window.focusedWindow():moveOneScreenSouth() end) -- Move window down
-- hs.hotkey.bind(hyper, "K", function() hs.window.focusedWindow():moveOneScreenNorth() end) -- Move window up

-- hs.hotkey.bind(hyper, "M", function() hs.window.focusedWindow():maximize() end)           -- Maximize window
-- hs.hotkey.bind(hyper, "C", function() hs.window.focusedWindow():centerOnScreen() end)     -- Center window
-- hs.hotkey.bind(hyper, "D", function() hs.window.focusedWindow():minimize() end)           -- Minimize window


-- Quick App Switcher (Hyper + Space)
hs.hotkey.bind(hyper, "space", function()
    hs.application.frontmostApplication():hide() -- Hide current app
    hs.eventtap.keyStroke({"cmd"}, "tab")        -- Simulate CMD + Tab
end)

-- app launching
local appMappings = {
    T = "Iterm", -- [T]erminal
    B = "Google Chrome", --[B]rowser
    C = "PyCharm", -- [C]ode
    -- P = "PyCharm", --[P]ycharm
    S = "Slack", -- [S]lack
    F = "Finder", -- [F]inder
    A = "Bruno", -- [A]pi
}

for key, app in pairs(appMappings) do
    hs.hotkey.bind(hyper, key, function() hs.application.launchOrFocus(app) end)
end

hs.hotkey.bind(hyper, 'm', function()
  local app = hs.application.frontmostApplication()
  for _, window in pairs(app:allWindows()) do
    window:minimize()
  end
end)

hs.hotkey.bind(hyper, 'u', function()
  local app = hs.application.frontmostApplication()
  for _, window in pairs(app:allWindows()) do
    window:unminimize()
  end
end)

hs.loadSpoon("Cherry")
spoon.Cherry:bindHotkeys({
    start = {hyper, "P"},  -- Start Pomodoro
})

hs.alert.show("Hammerspoon Loaded 🎉")
