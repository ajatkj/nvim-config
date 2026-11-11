return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")

    -- import fzf-extension for todo-comments
    local todo_list = require("todo-comments.fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>t", todo_list.todo, { desc = "List all notes, todos etc." })

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup({
      keywords = {
        IMPORTANT = { icon = " ", color = "info" },
      },
      merge_keywords = true
    })
  end,
}
