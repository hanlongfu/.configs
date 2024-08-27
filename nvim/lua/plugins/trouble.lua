local prefix = '<leader>'

return {
  'folke/trouble.nvim',
  cmd = { 'TroubleToggle', 'Trouble' },
  keys = {
    { prefix, desc = 'Trouble' },
    { prefix .. 'wd', '<cmd>TroubleToggle workspace_diagnostics<CR>', desc = 'workspace diagnostics' },
    { prefix .. 'dd', '<cmd>TroubleToggle document_diagnostics<CR>', desc = 'document diagnostics' },
    { prefix .. 'qd', '<cmd>TroubleToggle quickfix<CR>', desc = 'quickfix list(trouble)' },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    use_diagnostic_signs = true,
    action_keys = {
      close = { 'q', '<esc>' },
      cancel = '<C-e>',
    },
  },
}
