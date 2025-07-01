return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    })
  end,
}
