return {
  "tpope/vim-abolish",
  event = "VeryLazy",
  config = function()
    -- common mistyped words
    vim.cmd("Abolish teh the")
    vim.cmd("Abolish occured occurred")
    vim.cmd("Abolish hte the")
    vim.cmd("Abolish thme them")
    vim.cmd("Abolish htey they")
    vim.cmd("Abolish iwth with")
    vim.cmd("Abolish htat that")
    vim.cmd("Abolish myabe maybe")
    vim.cmd("Abolish exmaple example")
    vim.cmd("Abolish exmaples examples")
    vim.cmd("Abolish wihtout without")
    vim.cmd("Abolish varialbe variable")
    vim.cmd("Abolish itslef itself")
    vim.cmd("Abolish frist first")
    vim.cmd("Abolish wnat want")
    vim.cmd("Abolish almsot almost")
    vim.cmd("Abolish chnaging changing")
    vim.cmd("Abolish fisrt first")
    vim.cmd("Abolish thsi this")
  end,
}
