return {
  "stevearc/oil.nvim",
  lazy = false,
  config = function()
    require("oil").setup({
      float = {
        padding = 4,
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.5),
        border = "rounded",
      },
      win_options = {
        winhighlight = "Normal:OilFloat,NormalFloat:OilFloat,FloatBorder:OilBorder,EndOfBuffer:OilFloat,SignColumn:OilFloat,ColorColumn:OilFloat,CursorLine:OilFloat",
        -- winblend = 10, -- Try with 0 blend first
      },
    })

    vim.api.nvim_set_hl(0, "OilFloat", { bg = "none", fg = "none" })
    vim.api.nvim_set_hl(0, "OilBorder", { bg = "none", fg = "#89b4fa" })
  end,
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
}
