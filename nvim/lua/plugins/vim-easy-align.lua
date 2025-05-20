return {
  -- Define the plugin using your preferred package manager
  -- This example uses lazy.nvim, but can be adapted for packer or other managers
  {
    "junegunn/vim-easy-align",
    -- Make sure the plugin is loaded properly
    lazy = false,

    -- Configure the plugin after it's loaded
    config = function()
      -- Set up key mappings for easy-align
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })

      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })

      -- Optional: Extra configuration for EasyAlign if needed
      -- vim.g.easy_align_delimiters = {
      --   -- Add custom delimiters
      --   ['|'] = { pattern = '|', left_margin = 1, right_margin = 1 },
      --   [':'] = { pattern = ':', left_margin = 1, right_margin = 1 },
      --   ['='] = { pattern = '=', left_margin = 1, right_margin = 1 },
      --   [','] = { pattern = ',', left_margin = 0, right_margin = 1 },
      -- }
    end,
  },
}
