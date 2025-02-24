return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { "williamboman/mason.nvim", opts = {}}, -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      "williamboman/mason-lspconfig.nvim",
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = { progress = { display = { done_ttl = 8 } } } }, -- Useful status updates for LSP.
      "hrsh7th/cmp-nvim-lsp", -- Allows extra capabilities provided by nvim-cmp
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)

          -- helper function for defining mappings specific for LSP related items
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        end,
      })

      -- Configure diagnostics
      vim.diagnostic.config({
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
          },
        },
        virtual_text = false,  -- Disable inline diagnostics
        underline = true, -- Underline the problems
        float = {
          source = true,
          severity_sort = true,
          format = function(diagnostic)
            local severity_names = {
              [vim.diagnostic.severity.ERROR] = "Error",
              [vim.diagnostic.severity.WARN] = "Warn",
              [vim.diagnostic.severity.INFO] = "Info",
              [vim.diagnostic.severity.HINT] = "Hint",
            }
            local severity = severity_names[diagnostic.severity] or "Unknown"
            return string.format("[%s] %s", severity, diagnostic.message)
          end,
        },
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {

        -- lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' }, -- Supress "undefined global vim" warning
                disable = { 'missing-fields' } -- Ignore Lua_LS's noisy `missing-fields` warnings
              },
            },
          },
        },

        -- python
        pyright = {
          settings = {
            python = {
              analysis = {
                ignore = { '*' }, -- using ruff
              }
            }
          }
        },
        ruff = {
          settings = {
            lint = {
              enable = true,
            },
          },
        },

        -- typescript
        ts_ls = {
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (installs handled via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

    end,
  }
}

-- Useful Commands:
-- ---------------
--
-- :LspInfo while in a file
--     Checks if there is an lsp for that file, if it is running, etc
--
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
