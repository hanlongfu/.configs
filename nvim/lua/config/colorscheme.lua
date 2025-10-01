return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  priority = 1000,
  config = function()
    vim.g.nightflyItalics = false
    vim.cmd("colorscheme nightfly")
  end,
}
