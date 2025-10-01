return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      dimInactive = true,
      colors = {
        theme = {
          all = {
            ui = { bg_gutter = "none" },
          },
        },
      },
      theme = "wave",
    })
    --load the colorscheme
    vim.cmd("colorscheme kanagawa")
  end,
}
