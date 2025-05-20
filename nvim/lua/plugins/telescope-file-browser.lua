-- telescope file browser plugin
return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      extensions = {
        file_browser = {
          hidden = { file_browser = true, folder_browser = true },
        },
      },
    })
    require("telescope").load_extension("file_browser")
    vim.api.nvim_set_keymap(
      "n",
      "<leader>tf",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { noremap = true }
    )
  end,
}
