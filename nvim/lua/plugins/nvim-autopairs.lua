return {
  "windwp/nvim-autopairs",
  enabled = true,
  -- Optional dependency
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- enable treesitter integration
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })

    -- enable backtick only in markdown and javascript
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    -- Remove default backtick rule and add custom one
    npairs.remove_rule("`")
    npairs.add_rule(Rule("`", "`", { "markdown", "javascript", "typescript" }))

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
