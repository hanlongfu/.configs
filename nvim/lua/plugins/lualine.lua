return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local colors = {
      bg = "#292c33",
      fg = "#ffffff",
      red = "#bf6b69",
      green = "#b7bd73",
      yellow = "#e9c880",
      blue = "#88a1bb",
      magenta = "#ad95b8",
      cyan = "#95bdb7",
      white = "#eaeaea",
      black = "#1d1f21",
      comment = "#666666",
      selection = "#3a3f47",
      cursor = "#ffffff",
      -- Bright variants
      bright_red = "#c55757",
      bright_green = "#bcc95f",
      bright_yellow = "#e1c65e",
      bright_blue = "#83a5d6",
      bright_magenta = "#bc99d4",
      bright_cyan = "#83beb1",
    }

    -- Create custom lualine theme
    local custom_theme = {
      normal = {
        a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
        b = { fg = colors.fg, bg = colors.selection },
        c = { fg = colors.fg, bg = colors.bg },
      },
      insert = {
        a = { fg = colors.bg, bg = colors.green, gui = "bold" },
        b = { fg = colors.fg, bg = colors.selection },
        c = { fg = colors.fg, bg = colors.bg },
      },
      visual = {
        a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
        b = { fg = colors.fg, bg = colors.selection },
        c = { fg = colors.fg, bg = colors.bg },
      },
      replace = {
        a = { fg = colors.bg, bg = colors.red, gui = "bold" },
        b = { fg = colors.fg, bg = colors.selection },
        c = { fg = colors.fg, bg = colors.bg },
      },
      command = {
        a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
        b = { fg = colors.fg, bg = colors.selection },
        c = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        a = { fg = colors.comment, bg = colors.bg },
        b = { fg = colors.comment, bg = colors.bg },
        c = { fg = colors.comment, bg = colors.bg },
      },
    }
    require("lualine").setup({
      options = {
        theme = custom_theme,
        globalstatus = true, --single status line at bottom instead of per-window
      },
    })
  end,
  -- Make sure lualine loads after our color scheme
  dependencies = { "RRethy/base16-nvim", "nvim-tree/nvim-web-devicons" },
}
