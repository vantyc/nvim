-- ~/.config/nvim/lua/plugins/prompt.lua
return {
  {
    "nvim-lua/popup.nvim",
    config = function()
      local popup = require("popup")

      local function create_prompt()
        local win_id, win = popup.create("Enter your input: ", {
          line = "cursor+1",
          col = "cursor-1",
          minwidth = 20,
          minheight = 1,
          border = {},
        })

        vim.api.nvim_buf_set_option(win.bufnr, "buftype", "prompt")
        vim.fn.prompt_setprompt(win.bufnr, "> ")

        vim.api.nvim_buf_set_keymap(win.bufnr, "i", "<CR>", "<cmd>lua require('prompt').on_submit()<CR>", { noremap = true, silent = true })
      end

      local function on_submit()
        local input = vim.fn.getline(".")
        print("You entered: " .. input)
        vim.api.nvim_win_close(0, true)
      end

      _G.prompt = {
        create_prompt = create_prompt,
        on_submit = on_submit,
      }
    end,
  },
  { "nvim-lua/plenary.nvim" },
}
