return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("dap").set_log_level("TRACE")

      -- Session-local keymaps: active only while debugging
      local debug_keymaps = {
        { "s", function() require("dap").step_over() end, "Step Over" },
        { "S", function() require("dap").step_into() end, "Step Into" },
        { "B", function() require("dap").step_out() end, "Step Out (Back)" },
        -- { "r", function() require("dap").continue() end, "Resume" },
        { "K", function() require("dap.ui.widgets").hover() end, "Eval" },
      }
      local saved_keymaps = {}

      local dap = require("dap")
      dap.listeners.after.event_initialized["debug_keymaps"] = function()
        saved_keymaps = {}
        for _, map in ipairs(debug_keymaps) do
          -- Save existing mapping if any
          local existing = vim.fn.maparg(map[1], "n", false, true)
          if existing and existing.lhs then
            table.insert(saved_keymaps, existing)
          end
          vim.keymap.set("n", map[1], map[2], { desc = "DAP: " .. map[3] })
        end
      end

      local function restore_keymaps()
        for _, map in ipairs(debug_keymaps) do
          pcall(vim.keymap.del, "n", map[1])
        end
        for _, map in ipairs(saved_keymaps) do
          vim.fn.mapset("n", false, map)
        end
        saved_keymaps = {}
      end

      dap.listeners.before.event_terminated["debug_keymaps"] = restore_keymaps
      dap.listeners.before.event_exited["debug_keymaps"] = restore_keymaps
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>de", function() require("dap.ui.widgets").hover() end, desc = "Eval Under Cursor" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>dw", function() require("dapui").elements.watches.add(vim.fn.expand("<cword>")) end, desc = "Watch Word Under Cursor" },
      { "<leader>dg", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dapui = require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.4 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.15 },
            },
            size = 50,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- Auto open/close UI when debug session starts/ends
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Quit all dap-related buffers when closing the main code window
      vim.api.nvim_create_autocmd("QuitPre", {
        callback = function()
          local dap_patterns = { "dap-", "%[dap" }
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local name = vim.api.nvim_buf_get_name(buf)
            local ft = vim.bo[buf].filetype
            for _, pat in ipairs(dap_patterns) do
              if name:find(pat) or ft:find("dap") then
                pcall(vim.api.nvim_buf_delete, buf, { force = true })
                break
              end
            end
          end
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "python",
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

      -- Attach to sampling-coordinator running with DEBUG=1 (debugpy on port 5773)
      local dap = require("dap")
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach: Sampling Coordinator (port 5773)",
        connect = {
          host = "127.0.0.1",
          port = 5773,
        },
        pathMappings = {
          {
            localRoot = vim.fn.getcwd() .. "/sampling-coordinator",
            remoteRoot = "/mobius/sampling-coordinator",
          },
          {
            localRoot = vim.fn.getcwd() .. "/common",
            remoteRoot = "/mobius/sampling-coordinator/src/common",
          },
          {
            localRoot = vim.fn.getcwd() .. "/service_packages",
            remoteRoot = "/mobius/sampling-coordinator/src/service_packages",
          },
        },
      })

      -- Attach to API running with DEBUG=1 (debugpy on port 5768)
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach: API (port 5768)",
        connect = {
          host = "127.0.0.1",
          port = 5768,
        },
        pathMappings = {
          {
            localRoot = vim.fn.getcwd() .. "/service_packages",
            remoteRoot = "/mobius/api/src/service_packages",
          },
          {
            localRoot = vim.fn.getcwd() .. "/common",
            remoteRoot = "/mobius/api/src/common",
          },
          {
            localRoot = vim.fn.getcwd() .. "/api",
            remoteRoot = "/mobius/api",
          },
        },
      })

      -- Generic attach: prompts for host and port
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach: Remote (prompt for port)",
        connect = function()
          local host = vim.fn.input("Host [127.0.0.1]: ")
          if host == "" then host = "127.0.0.1" end
          local port = tonumber(vim.fn.input("Port [5678]: "))
          if not port then port = 5678 end
          return { host = host, port = port }
        end,
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(),
            remoteRoot = ".",
          },
        },
      })
    end,
  },
}
