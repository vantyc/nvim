return {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
    config = function()
        -- Opciones personalizadas (si las necesitas)
        vim.g.mkdp_auto_start = 1  -- Previsualizar automáticamente al abrir un archivo Markdown
        vim.g.mkdp_browser = ''    -- Dejar vacío para usar el navegador predeterminado
    end,
}

