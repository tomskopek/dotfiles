return {
  {
    "L3MON4D3/LuaSnip",
    enabled = true,
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
      -- Important note: luasnip is already setup() in nvim-cmp

      local ls = require("luasnip")
      local t, i, c, f = ls.text_node, ls.insert_node, ls.choice_node, ls.function_node
      local fmt = require("luasnip.extras.fmt").fmt
      local extras = require("luasnip.extras")
      local rep = extras.rep

      vim.keymap.set({ "i", "s" }, "<C-N>", function()
        ls.jump(1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-P>", function()
        ls.jump(-1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<c-y>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })

      local console_log = ls.s(
        "clo",
        fmt("console.log({logmsg});", {
          logmsg = c(1, {
            ls.sn(1, { t("{ "), i(1, "object"), t(" }") }),
            { t("'"), i(1, "hello world"), t("'") },
            { t("'"), rep(1), t("', "), i(1, "var") },
            i(1, "basic"),
          }),
        })
      )

      local jslike = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      for _, lang in pairs(jslike) do
        ls.add_snippets(lang, { console_log })
      end

      local ipdb = ls.s("ipst", t("__import__('ipdb').set_trace()"))
      ls.add_snippets("python", { ipdb })
    end,
  },
}
