-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
-- Avoid new line while pasting
vim.keymap.set('n', 'dil', "dd:let @+=matchlist(strtrans(@+),'[ ]*\\zs.*\\ze\\^@')[0]<CR>")
-- buffer commands
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>write<cr><cmd>quit<cr>")
vim.keymap.set("n", "<leader>9", "<cmd>bp<cr>")
vim.keymap.set("n", "<leader>0", "<cmd>bn<cr>")

-- switch file explorer
vim.keymap.set("n", "<leader>e", "<c-w><c-w>")
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")

-- Telescope
vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")

-- LSP
vim.keymap.set('n', '<C-d>', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
vim.keymap.set('n', '<S-R>', ':lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<S-H>', ':lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>nc', ':lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<leader>fr', ':lua require"telescope.builtin".lsp_references()')

-- Postman
-- Turn off the default key binging
vim.g.vrc_set_default_mapping = 0
-- Set the default response conteit type to JSOM
vim.g.vrc_response_default_content_type = 'application/json'
-- Set the output buffer name
vim.vrc_output_buffer_name = '_OUTPUT.json'
--Fun a format comand on the response buffer
vim.g.vrc_auto_format_response_patters = {
    json='jq',
}
-- Vim REST Console
vim.keymap.set("n","<leader>xr", "<cmd>VrcQuery()<CR>" )

