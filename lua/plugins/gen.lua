-- gen.nvim: deshabilitado - funcionalidad consolidada en avante (Ollama)
return {
  "David-Kunz/gen.nvim",
  enabled = false,
  cmd = { "Gen" },
  opts = {
    model = "qwen2.5-coder:7b",
    host = "localhost",
    port = "11434",
    display_mode = "float",
    init = function()
      pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
    end,
  },
  config = function(_, opts)
    require("gen").setup(opts)

    -- Prompts custom para explain y refactor
    require("gen").prompts["Explain_Selection"] = {
      prompt = "Explica el siguiente código en detalle:\n```$filetype\n$text\n```",
      replace = false,
    }
    require("gen").prompts["Refactor"] = {
      prompt = "Refactoriza el siguiente código. Solo output en formato ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
    }

    local keymap = vim.keymap
    keymap.set("n", "<leader>cc", ":Gen Chat<CR>", { desc = "Abrir chat" })
    keymap.set({ "n", "v" }, "<leader>ce", ":Gen Explain_Selection<CR>", { desc = "Explicar selección" })
    keymap.set({ "n", "v" }, "<leader>cr", ":Gen Refactor<CR>", { desc = "Refactorizar" })
  end,
}
