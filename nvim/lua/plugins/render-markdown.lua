return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  opts = {
    completions = { lsp = { enabled = true } },
    code = { style = "normal" },
    heading = { position = "inline" },
    sign = { enabled = false },
  },
}
