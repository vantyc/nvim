-- Code Tree Support / Syntax Highlighting
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    ensure_installed = {
      'bash',
      'css',
      'dockerfile',
      'html',
      'java',
      'javascript',
      'lua',
      'rust',
      'scss',
      'typescript',
      'yaml',
    },
  },
  config = function(_, opts)
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok and configs then
      configs.setup(opts)
    end
  end,
}

