return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",  -- Cargar solo cuando entres en modo Insert
  config = function()
    require("better_escape").setup({
      mapping = { "jj" },  -- Teclas para salir de Insert
      timeout = 300,       -- Tiempo máximo entre pulsaciones
      clear_empty_lines = false, -- No borrar líneas en blanco
      keys = "<Esc>"       -- Simular Escape
    })
  end,
}

