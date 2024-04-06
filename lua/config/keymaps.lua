-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
-- buffer commands
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>write<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>write<cr><cmd>quit<cr>")
vim.keymap.set("n", "<leader>9", "<cmd>bp<cr>")
vim.keymap.set("n", "<leader>0", "<cmd>bn<cr>")

-- switch file explorer
vim.keymap.set("n", "<leader>e", "<c-w><c-w>")
vim.keymap.set("n", "<leader>n", "<cmd>Neotree toggle<cr>")

-- Telescope
vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
