-- Desactiva nvim-cmp completado automático SOLO para Java
vim.defer_fn(function()
  local ok, cmp = pcall(require, "cmp")
  if ok then
    cmp.setup.buffer({
      sources = {},
      enabled = function() return false end,
    })
  end
end, 100)

-- Por si otro plugin (como jdtls) sobreescribe, recargamos esto con fuerza bruta
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.java",
  callback = function()
    vim.defer_fn(function()
      local ok, cmp = pcall(require, "cmp")
      if ok then
        cmp.setup.buffer({
          sources = {},
          enabled = function() return false end,
        })
      end
    end, 100)
  end,
})

