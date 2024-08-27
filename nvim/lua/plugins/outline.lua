-- displays an outline of symbols in the code
return {
  'hedyhli/outline.nvim',
  config = function()
    -- example mapping to toggle outline
    vim.keymap.set('n', '<leader>o', '<cmd>Outline<cr>', { desc = 'toggle outline' })

    require('outline').setup {
      -- Your setup opts here (leave empty to use defaults)
    }
  end,
}
