local function shouldBlockCmdR()
    local app = hs.application.frontmostApplication()
    return app and app:name() == "iTerm2"
end

local hotkey = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()

    -- CMD + R KeyCode is 15 (https://www.hammerspoon.org/docs/hs.keycodes.html#map)
    if flags.cmd and not (flags.alt or flags.ctrl or flags.shift) and keyCode == hs.keycodes.map["r"] then
        if shouldBlockCmdR() then
            hs.alert.show("⌘ + R disabled in iTerm2 (Hammerspoon)")
            return true -- Block the key event in iTerm2
        end
    end

    return false -- Allow the event through for all other apps
end)

hotkey:start()
