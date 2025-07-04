return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  name = "bufferline",
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "next tab" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "prev tab" },
    { "<leader>bl", "<cmd>BufferLinePick<CR>", desc = "pick a buffer" },
    { "<leader>bx", "<cmd>bdelete %<CR>", desc = "close buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "close all other tabs except current" },
  },
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "buffers",
        separator_style = { "", "" },
        always_show_bufferline = false,
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        numbers = "id",
        show_buffer_icons = false,
        show_tab_indicators = false,
        persist_buffer_sort = true,
        enforce_regular_tabs = true,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        show_buffer_close_icons = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = false,
          },
        },
        diagnostics = "nvim_lsp",
      },
      highlights = {
        indicator_selected = {
          fg = "#7aa2f7",
        },
      },
    })
  end,
}
