-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Java
keymap.set("n", '<F9>', '<cmd>w!<cr><cmd>!java %<cr>')
-- F9 también funciona desde modo inserción: guarda, compila y vuelve a inserción
vim.api.nvim_set_keymap('i', '<F9>', '<Esc>:w<CR>:term java %<CR>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', ':w<CR>:term java %<CR>i', { noremap = true, silent = true })

-- Buffers
keymap.set("n", "<leader>9", "<cmd>bp<cr>")
keymap.set("n", "<leader>0", "<cmd>bn<cr>")

-- Prompt Copilot
keymap.set("n", "<leader>p", "<cmd>lua require('prompt').create_prompt()<CR>", { noremap = true, silent = true })

-- General keymaps
keymap.set("n", "<leader>s", "<cmd>w!<cr>") -- save
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>q", ":bd<CR>") -- close buffer
keymap.set("n", "<leader>ww", ":w<CR>") -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor
keymap.set("n", "<C-w>", ":set wrap!<CR>") -- toggle wrap

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger 
keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

-- Toggle autocompletion (nvim-cmp) and remove supermaven
keymap.set("n", "<leader>ac", function()
    local cmp = require('cmp')
    if cmp.get_config().enabled then
        cmp.setup.buffer({ enabled = false, sources = {} }) -- Desactiva y elimina fuentes
        print("Auto-completion disabled")
    else
        cmp.setup.buffer({
            enabled = true,
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" }
            }
        })
        print("Auto-completion enabled")
    end
end, { noremap = true, silent = true })

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c") -- next diff hunk
keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>") -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>") -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- Nvim-tree
keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
keymap.set("n", "<leader>e", "<c-w><c-w>")
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- Telescope
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, {})
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, {})
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, {})

-- Git-blame
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>") -- toggle git blame

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
for i = 1, 9 do
    keymap.set("n", "<leader>h" .. i, function() require("harpoon.ui").nav_file(i) end)
end

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- Run REST query

-- LSP
keymap.set('n', '<leader>gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Toggle Supermaven correctamente sin afectar LSP ni snippets
local supermaven_enabled = true

vim.keymap.set('n', '<leader>sm', function()
  local cmp = require('cmp')
  if supermaven_enabled then
    -- Quitamos Supermaven de las sources
    cmp.setup.buffer {
      sources = {
        { name = "nvim_lsp" }, -- Deja activo LSP
        { name = "luasnip" },  -- Snippets
        { name = "buffer" },
        { name = "path" },
      }
    }
    print("🛑 Supermaven Desactivado")
  else
    -- Volvemos a agregar Supermaven
    cmp.setup.buffer {
      sources = {
        { name = "supermaven" }, -- Reactivas Supermaven
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }
    }
    print("✅ Supermaven Activado")
  end
  supermaven_enabled = not supermaven_enabled
end, { noremap = true, silent = true, desc = "Toggle Supermaven" })

vim.api.nvim_create_user_command("FormatJava", function()
  local file = vim.fn.expand("%")
  vim.cmd("write") -- Guarda antes de formatear
  os.execute("google-java-format -i " .. file)
  vim.cmd("edit")  -- Recarga archivo
end, {})

vim.keymap.set("n", "<leader>fj", ":FormatJava<CR>", { desc = "Formatear Java con google-java-format" })
