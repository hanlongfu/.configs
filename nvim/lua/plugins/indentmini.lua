return {
  "nvimdev/indentmini.nvim",
  config = function()
    require("indentmini").setup()

    vim.cmd.highlight("IndentLine guifg =#443c38")
    vim.cmd.highlight("IndentLineCurrent guifg=#695d55")
  end,
}
