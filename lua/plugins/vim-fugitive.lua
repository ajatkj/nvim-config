return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>",                  desc = "Git status" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>",           desc = "Git diff split" },
    { "<leader>gc", "<cmd>Git commit<cr>",           desc = "Git commit" },
    { "<leader>gb", "<cmd>Git blame<cr>",            desc = "Git blame" },
    { "<leader>gm", "<cmd>Git mergetool<cr>",        desc = "Git mergetool" },

    -- Quick conflict resolution
    { "<leader>gj", "<cmd>diffget //3<cr>",          desc = "Get from right (//3)" },
    { "<leader>gf", "<cmd>diffget //2<cr>",          desc = "Get from left (//2)" },

    -- Conflict stats
    { "<leader>gC", "<cmd>call ConflictStats()<cr>", desc = "Show conflict stats" },
  },
  config = function()
    -- Improve diff experience
    vim.opt.diffopt:append("algorithm:patience")
    vim.opt.diffopt:append("indent-heuristic")

    -- Define ConflictStats function
    vim.cmd([[
      function! ConflictStats()
        let l:conflict_pattern = '^<<<<<<< '
        let l:conflicts = search(l:conflict_pattern, 'n')
        echo "Remaining conflicts: " . l:conflicts
      endfunction
    ]])
  end,
}
