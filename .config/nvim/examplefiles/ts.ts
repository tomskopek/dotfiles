// test.ts
// This file is for testing your LSP (Language Server Protocol) setup in Neovim

// If LSP *IS* working, you should see:
// - Syntax highlighting
// - Autocompletion suggestions
// - Function signatures / parameter hints
// - Diagnostics (errors/warnings) underlined
// - Hover information on symbols
// - Ability to jump to definition or references
// - Type inference and info on hover

// If LSP is *NOT* working, you might see:
// - No autocompletion
// - No diagnostics even for obvious errors
// - No hover info
// - 'Go to definition' does nothing or errors

// Example function with an intentional error
function addNumbers(a: number, b: number): number {
    return a + c;  // 'c' is undefined, should trigger an error
}

// Example variable
const greeting: string = "Hello, world!";

// Function calls
console.log(greeting);
console.log(addNumbers(2, 3));

// Example of an unused variable (should trigger a warning if supported)
const unusedVar = 42;

// Example interface and class
interface PersonInterface {
    name: string;
    greet(): string;
}

class Person implements PersonInterface {
    name: string;

    constructor(name: string) {
        this.name = name;
    }

    greet(): string {
        return `Hi, I'm ${this.name}`;
    }
}

const alice = new Person("Alice");
console.log(alice.greet());
