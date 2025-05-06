local opt = vim.opt

-- === Session Management ===
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- === Line Numbers ===
opt.relativenumber = true
opt.number = true

-- === Tabs & Indentation ===
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
vim.bo.softtabstop = 2

-- === Line Wrapping ===
opt.wrap = false

-- === Search Settings ===
opt.ignorecase = true
opt.smartcase = true

-- === Cursor Line ===
opt.cursorline = true

-- === Appearance ===
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.diagnostic.config({
  float = { border = "rounded" },
})

-- === Backspace ===
opt.backspace = "indent,eol,start"

-- === Clipboard ===
opt.clipboard:append("unnamedplus")

-- === Split Windows ===
opt.splitright = true
opt.splitbelow = true

-- === Consider - as part of keyword ===
opt.iskeyword:append("-")

-- === Mouse ===
opt.mouse = ""

-- === Folding (Treesitter) ===
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- === Syntax & Filetype ===
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- === Color scheme (elige uno) ===
vim.cmd([[colorscheme ayu]])
-- vim.cmd([[colorscheme gruvbox]])
-- vim.cmd([[colorscheme tokyonight]])
