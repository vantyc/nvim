-- vim-dadbod + vim-dadbod-ui: SQL desde Neovim
return {
  'kristijanhusak/vim-dadbod-ui',
  cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
  dependencies = { 'tpope/vim-dadbod' },
  init = function()
    local data_path = vim.fn.stdpath('data')
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
    vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
    vim.g.db_ui_use_nerd_fonts = 1

    -- Conexión local Postgres (ajusta user/password/db si necesario)
    vim.g.dbs = {
      local_postgres = 'postgresql://localhost:5432/postgres',
    }
  end,
  config = function()
    vim.keymap.set('n', '<leader>sq', '<cmd>DBUIToggle<cr>', { desc = 'Dadbod UI: abrir' })
  end,
}
