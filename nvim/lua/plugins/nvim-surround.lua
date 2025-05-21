-- this plugin add, delete, or change surrounding pairs
-- to add: ys{motion}{char}     ysiw) - surround words with parent
-- to delete: ds{char}          ds] - delete []
-- to change: cs{target}{repalcement}         cs'" - chang single quotes to double quotes
-- to add delimiters to multiple words, first select them, then S<delimiter>
return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end,
}
