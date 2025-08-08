-- test.lua
-- This file is for testing your LSP (Language Server Protocol) setup in Neovim

-- If LSP *IS* working, you should see:
-- - Syntax highlighting
-- - Autocompletion suggestions
-- - Function signatures / parameter hints
-- - Diagnostics (errors/warnings) underlined
-- - Hover information on symbols
-- - Ability to jump to definition or references

-- If LSP is *NOT* working, you might see:
-- - No autocompletion
-- - No diagnostics even for obvious errors
-- - No hover info
-- - 'Go to definition' does nothing or gives an error

-- Example function with an intentional error
local function add_numbers(a, b)  -- b is not used
    return a + c  -- 'c' is undefined, LSP should show an error
end

-- Example variable
local greeting = "Hello, world!"

-- Function call
print(greeting)
print(add_numbers(2, 3))

-- Example of an unused variable (should trigger a warning if supported)
local unused_var = 42

-- Example table and method
local Person = {}
Person.__index = Person

function Person:new(name)
    local instance = setmetatable({}, Person)
    instance.name = name
    return instance
end

function Person:greet()
    return "Hi, I'm " .. self.name
end

local alice = Person:new("Alice")
print(alice:greet())
