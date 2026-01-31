# test.py
# This file is for testing your LSP (Language Server Protocol) setup in Neovim

# If LSP *IS* working, you should see:
# - Syntax highlighting
# - Autocompletion suggestions
# - Function signatures / parameter hints
# - Diagnostics (errors/warnings) underlined
# - Hover information on symbols
# - Ability to jump to definition or references
# - Type inference and info on hover

# If LSP is *NOT* working, you might see:
# - No autocompletion
# - No diagnostics even for obvious errors
# - No hover info
# - 'Go to definition' does nothing or errors

# Example function with an intentional error
def add_numbers(a: int, b: int) -> int:
    return a + c  # 'c' is undefined, should trigger an error

# Example variable
greeting: str = "Hello, world!"

# Function calls
print(greeting)
print(add_numbers(2, 3))

# Example of an unused variable (should trigger a warning if supported)
unused_var = 42

# Example class with type annotations
class Person:
    def __init__(self, name: str):
        self.name = name

    def greet(self) -> str:
        return f"Hi, I'm {self.name}"

alice = Person("Alice")
print(alice.greet())
