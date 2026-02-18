-- Neotest: framework de tests
return {
  'nvim-neotest/neotest',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'rcasia/neotest-java',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    local neotest = require('neotest')

    neotest.setup({
      adapters = {
        require('neotest-java')(),
        require('neotest-jest')({
          jestCommand = 'npm test --',
          cwd = function() return vim.fn.getcwd() end,
        }),
      },
      summary = {
        open = 'botright vsplit | vertical resize 50',
      },
    })

    -- Keymaps
    vim.keymap.set('n', '<leader>tt', function()
      neotest.run.run()
    end, { desc = 'Run test under cursor' })

    vim.keymap.set('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand('%'))
    end, { desc = 'Run test file' })

    vim.keymap.set('n', '<leader>ts', function()
      neotest.summary.toggle()
    end, { desc = 'Toggle neotest summary' })
  end,
}
