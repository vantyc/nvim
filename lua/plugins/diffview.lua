-- diffview.nvim: Git diffs e historial de archivos
return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('diffview').setup()

    -- gd/gh ya usados por LSP (definition/hover); usamos gv/gH para diffview
    vim.keymap.set('n', '<leader>gv', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview: abrir diff' })
    vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', { desc = 'Diffview: historial archivo' })
  end,
}
