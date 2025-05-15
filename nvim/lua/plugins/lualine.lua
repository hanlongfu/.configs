return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = _G.custom_lualine_theme or "auto", -- Use our custom theme if available
      },
    })
  end,
  -- Make sure lualine loads after our color scheme
  dependencies = { "RRethy/base16-nvim", "nvim-tree/nvim-web-devicons" },
}
