return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "jellybeans",
      },
    })
  end,
  -- Make sure lualine loads after our color scheme
  dependencies = { "RRethy/base16-nvim", "nvim-tree/nvim-web-devicons" },
}
