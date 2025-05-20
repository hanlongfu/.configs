return {
  "godlygeek/tabular",
  cmd = { "Tabularize", "Tabular" },
  keys = {
    { "<leader>a=", ":Tabular /=/<CR>", mode = { "n", "v" }, desc = "Align on equal sign" },
    { "<leader>a:", ":Tabular /:/<CR>", mode = { "n", "v" }, desc = "Align on colon" },
    { "<leader>a,", ":Tabular /,/<CR>", mode = { "n", "v" }, desc = "Align on comma" },
    { "<leader>a#", ":Tabular /#/<CR>", mode = { "n", "v" }, desc = "Align on number sign" },
    { "<leader>a&", ":Tabular /&/<CR>", mode = { "n", "v" }, desc = "Align on ampersand" },
    { "<leader>a/", [[:Tabular /\/\//<CR>]], mode = { "n", "v" }, desc = "Align on two forward slashes" },
  },
}
