-- refactoring.nvim: Extract function, variable, etc.
return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
  config = function(_, opts)
    require('refactoring').setup(opts)

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>re',
      function() return require('refactoring').refactor('Extract Function') end,
      { expr = true, desc = 'Extract function' }
    )
    vim.keymap.set(
      { 'n', 'x' },
      '<leader>rv',
      function() return require('refactoring').refactor('Extract Variable') end,
      { expr = true, desc = 'Extract variable' }
    )
  end,
}
