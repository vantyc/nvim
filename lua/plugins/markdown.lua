-- ~/.config/nvim/lua/plugins/markdown.lua
return {
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    ft = { 'markdown' },
    config = function()
      require('render-markdown').setup({})
    end,
  },
  {
    'godlygeek/tabular',
    ft = { 'markdown' },
  },
  {
    'preservim/vim-markdown',
    ft = { 'markdown' },
    dependencies = { 'godlygeek/tabular' },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
    end,
  },
}
