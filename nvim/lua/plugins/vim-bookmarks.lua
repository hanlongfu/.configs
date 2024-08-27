-- set bookmarks
return {
  'MattesGroeger/vim-bookmarks',
  dependencies = {
    'tom-anders/telescope-vim-bookmarks.nvim',
  },
  config = function()
    require('telescope').load_extension 'vim_bookmarks'
    local keymap = vim.keymap
    keymap.set('n', 'ma', '<cmd>lua require("telescope").extensions.vim_bookmarks.all()<cr>')
    keymap.set('n', 'mc', '<cmd>lua require("telescope").extensions.vim_bookmarks.current_file()<cr>')
  end,
}
