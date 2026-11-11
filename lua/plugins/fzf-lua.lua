return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>/c",
      function()
        require("neoclip.fzf")()
      end,
      desc = "Search commands",
    },
    {
      '<leader>"',
      function()
        require("fzf-lua").registers()
      end,
      desc = "Search all registers",
    },
    {
      "<leader>s",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Search current word string in files",
    },
    {
      "<leader>S",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "Search string in files",
    },
    {
      "<leader>/C",
      function()
        require("fzf-lua").command_history()
      end,
      desc = "Search command history",
    },
    {
      "<leader>f",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find files",
    },
    {
      "<leader>F",
      function()
        require("fzf-lua").files({ resume = true })
      end,
      desc = "Find files (resume)",
    },
    {
      "<leader>/o",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Find files",
    },
    {
      "<leader>b",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Open buffers",
    },
    {
      "<leader>a",
      function()
        require("fzf-lua").grep({ resume = true })
      end,
      desc = "Search again with last pattern",
    },
    {
      "<leader>/M",
      function()
        require("fzf-lua").marks()
      end,
      desc = "Search marks",
    },
    {
      "<leader>/k",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "Search keymaps",
    },
    {
      "<leader>/t",
      function()
        require("fzf-lua").treesitter()
      end,
      desc = "Search treesitter",
    },
    {
      "<leader>/gf",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "Find git files",
    },
    {
      "<leader>/gb",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "Search git branches",
    },
    {
      "<leader>/gc",
      function()
        require("fzf-lua").git_commits()
      end,
      desc = "Search git commits",
    },
    {
      "<leader>/gC",
      function()
        require("fzf-lua").git_bcommits()
      end,
      desc = "Search git buffer commits",
    },
    {
      "<leader>/b",
      function()
        require("fzf-lua").git_bcommits()
      end,
      desc = "Search git buffer commits",
    },
    {
      "<leader>//",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume FZF",
    },
  },
  config = function()
    -- calling `setup` is optional for customization
    local fzf_lua = require("fzf-lua")
    require("fzf-lua").register_ui_select()
    fzf_lua.setup({
      "telescope", -- Use telescope profile
      defaults = {
        file_icons = true,
        git_icons = true,
        color_icons = true,
        formatter = "path.filename_first",
      },
      winopts = {
        preview = {
          layout = "horizontal",
          title_pos = "left",
        },
        height = 0.6,
      },
      keymap = {
        fzf = {
          ["CTRL-Q"] = "select-all+accept",
        },
      },
      previewers = {
        bat = { theme = "catppuccin", args = "--color=always --style=default" },
      },
      lsp = {
        code_actions = {
          -- winopts = {
          --   relative = "cursor",
          --   row = 1,
          --   col = 0,
          --   height = 0.2,
          --   preview = { vertical = "down:70%" },
          -- },
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
          preview_pager = "delta --width=$COLUMNS --hunk-header-style=omit --file-style=omit",
        },
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --ignore -e",
        rg_glob = true,
        -- first returned string is the new search query
        -- second returned string are (optional) additional rg flags
        -- @return string, string?
        glob_flag = "--iglob",     -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --',
      },
      files = {
        fzf_opts = { ["--layout"] = "reverse-list" },
        cwd_prompt = false,
        git_icons = true,
        cwd_header = false,
        prompt = "❯ ",
        winopts = {
          fullscreen = false,
          preview = {
            hidden = false
          },
        },
      },
      buffers = {
        cwd_header = true,
        header = false,
        winopts = {
          preview = {
            hidden = "hidden",
          },
        },
      },
    })
  end,
}
