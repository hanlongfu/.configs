return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
  },
  config = function()
    -- Optional: place any Undotree-specific settings here
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}
