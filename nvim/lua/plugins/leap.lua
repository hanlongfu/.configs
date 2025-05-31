return {
  "ggandor/leap.nvim",
  enabled = true,
  config = function()
    local leap = require("leap")
    leap.add_default_mappings(false)

    -- set up your custom key mapping with <leader>f
    vim.keymap.set({ "n", "x", "o" }, "<leader>f", "<Plug>(leap-forward)", { desc = "leap forward" })
    vim.keymap.set({ "n", "x", "o" }, "<leader>F", "<Plug>(leap-backward)", { desc = "leap backward" })

    -- customize the highlight color
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
    vim.api.nvim_set_hl(0, "LeapMatch", {
      fg = "white",
      bold = true,
      nocombine = true,
    })
  end,
}
