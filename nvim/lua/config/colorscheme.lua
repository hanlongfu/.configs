return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.nightflyItalics = false
    vim.g.moonflyTransparent = false
    vim.cmd.colorscheme("nightfly")
  end,
}
