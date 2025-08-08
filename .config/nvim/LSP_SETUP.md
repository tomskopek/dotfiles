# LSP Server Installation Guide

This document contains manual installation instructions for the LSP servers used in this Neovim configuration.

## Prerequisites

Ensure you have the following package managers installed:
- `npm` (for JavaScript/TypeScript servers)
- `pip` (for Python servers)
- `brew` (for macOS users) or your system's package manager

## Language Server Installation

### Lua Language Server (lua_ls)

**Installation:**
```bash
# macOS (recommended)
brew install lua-language-server

# Alternative: Build from source
git clone https://github.com/LuaLS/lua-language-server
cd lua-language-server
./make.sh
```

**Config file:** `lsp/lua_ls.lua`

### Python Language Servers

#### basedpyright (Type checking, go-to-definition, completion)

**Installation:**
```bash
# Install via pip
pip install basedpyright

# Or via npm
npm install -g @basedpyright/pyright
```

#### ruff (Linting and formatting)

**Installation:**
```bash
# Install via pip (recommended)
pip install ruff

# Or via cargo
cargo install ruff

# Or via brew
brew install ruff
```

**Config files:** `lsp/basedpyright.lua`, `lsp/ruff.lua`

### JavaScript/TypeScript Language Server (ts_ls)

**Installation:**
```bash
# Install TypeScript Language Server
npm install -g typescript-language-server typescript
```

**Config file:** `lsp/ts_ls.lua`

## Verification

After installation, you can verify the servers are available:

```bash
# Check if servers are in PATH
which lua-language-server
which basedpyright
which ruff
which typescript-language-server
```

## Usage

1. Install the language servers using the commands above
2. Open a file of the appropriate type in Neovim
3. Run `:LspInfo` to check if the server is running
4. LSP features should be available automatically

## Troubleshooting

### Server not found
- Ensure the server is installed and in your PATH
- Check `:LspInfo` for error messages
- Restart Neovim after installation

### Server not starting
- Check if you have the required runtime (Node.js for ts_ls, Python for Python servers)
- Verify file associations are correct
- Check Neovim logs: `:messages`

### Configuration Issues
- LSP server configs are in `lsp/` directory
- Each server has its own `.lua` file
- Modify server settings in the respective config file

## Adding New Servers

To add a new language server:

1. Install the server binary
2. Create a new file: `lsp/server_name.lua`
3. Add the configuration:
   ```lua
   vim.lsp.config('server_name', {
     -- server settings here
   })
   
   vim.lsp.enable('server_name')
   ```

## Notes

- No Mason integration - all servers are manually installed
- Servers are loaded on-demand when opening relevant file types
- Formatting is handled by conform.nvim, not by LSP servers
- This setup prioritizes simplicity and control over auto-installation