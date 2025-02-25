return {
  {
    "L3MON4D3/LuaSnip",
    build = (function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      {
        "rafamadriz/friendly-snippets", -- `friendly-snippets` contains a variety of premade snippets.
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local ls = require("luasnip")
      local fmt = require("luasnip.extras.fmt").fmt
      local t, i, c, f = ls.text_node, ls.insert_node, ls.choice_node, ls.function_node

      -- these dont seem to work!
      --
      -- vim.keymap.set({ "i" }, "<C-K>", function()
      --   ls.expand()
      -- end, { silent = true })
      --
      -- vim.keymap.set({ "i", "s" }, "<C-W>", function()
      --   ls.jump(1)
      -- end, { silent = true })
      --
      -- vim.keymap.set({ "i", "s" }, "<C-J>", function()
      --   ls.jump(-1)
      -- end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })

      local same = function(index)
        return f(function(args)
          return args[1]
        end, { index })
      end

      local console_log = ls.s(
        "clo",
        fmt("console.log({logmsg});", {
          logmsg = c(1, {
            i(1, "basic"),
            ls.sn(1, { t("'"), i(1, "labelled"), t("', "), same(1) }),
            ls.sn(1, { t("{ "), i(1, "object"), t(" }") }),
          }),
        })
      )

      local jslike = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      for _, lang in pairs(jslike) do
        ls.add_snippets(lang, { console_log })
      end

      local ipdb = ls.s(
        "ipst",
        t("__import__('ipdb').set_trace()")
      )
      ls.add_snippets("python", { ipdb })

    end,
  },
}
