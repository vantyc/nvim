-- avante.nvim: AI asistente unificado (Ollama qwen2.5-coder)
return {
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "stevearc/dressing.nvim",
  },
  opts = {
    provider = "ollama",
    auto_suggestions_provider = nil,
    cursor_applying_provider = nil,
    providers = {
      ollama = {
        endpoint = "http://127.0.0.1:11434",
        model = "qwen2.5-coder:7b",
        timeout = 30000,
        extra_request_body = {
          options = {
            temperature = 0.5,
            num_ctx = 8192,
            keep_alive = "5m",
          },
        },
      },
    },
    dual_boost = { enabled = false },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
      enable_token_counting = true,
      enable_cursor_planning_mode = false,
    },
    mappings = {
      ask = "<leader>cc",
      new_ask = "<leader>cn",
      zen_mode = "<leader>cz",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      focus = "<leader>af",
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = { next = "]]", prev = "[[" },
      submit = { normal = "<CR>", insert = "<C-s>" },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
    },
    shortcuts = {
      {
        name = "explain",
        description = "Explicar código",
        prompt = "Explica el siguiente código en detalle.",
      },
      {
        name = "refactor",
        description = "Refactorizar código",
        prompt = "Refactoriza el código siguiendo mejores prácticas. Solo devuelve código, sin explicaciones adicionales.",
      },
    },
    hints = { enabled = true },
    windows = {
      position = "right",
      wrap = true,
      width = 30,
      sidebar_header = { enabled = true, align = "center", rounded = true },
      input = { prefix = "> ", height = 8 },
      edit = { border = "rounded", start_insert = true },
      ask = {
        floating = false,
        start_insert = true,
        border = "rounded",
        focus_on_apply = "ours",
      },
    },
    highlights = {
      diff = { current = "DiffText", incoming = "DiffAdd" },
    },
    diff = {
      autojump = true,
      list_opener = "copen",
      override_timeoutlen = 500,
    },
    suggestion = { debounce = 600, throttle = 600 },
  },
  config = function(_, opts)
    require("avante").setup(opts)

    -- Keymaps adicionales: explain y refactor (shortcuts rápidos)
    local api = require("avante.api")
    vim.keymap.set({ "n", "v" }, "<leader>ce", function()
      api.ask({ question = "Explica el siguiente código en detalle." })
    end, { desc = "Avante: explicar" })
    vim.keymap.set("v", "<leader>cr", function()
      api.edit("Refactoriza el código siguiendo mejores prácticas. Solo devuelve código.")
    end, { desc = "Avante: refactorizar" })
  end,
}
