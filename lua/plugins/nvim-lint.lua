return {
  "mfussenegger/nvim-lint",
  enabled = true,
  config = function()
    local lint = require("lint")
    -- Mypy can't find the virtual environment automatically even if it is activated
    -- local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
    -- lint.linters.mypy.args = { "--python-executable", virtual .. "/bin/python3" }
    lint.linters_by_ft = {
      -- Ruff is LSP as well as linter and formatter
      python = { "ruff" },
      php = { "phpstan" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      -- css = { "stylelint" },
      -- scss = { "stylelint" },
      sh = { "shellcheck" },
      bash = { "sheelcheck" },
      dockerfile = { "hadolint" },
    }

    lint.linters.eslint_d = require("lint.util").wrap(lint.linters.eslint_d, function(diagnostic)
      -- try to ignore "No ESLint configuration found" error
      -- if diagnostic.message:find("Error: No ESLint configuration found") then -- old version
      -- update: 20240814, following is working
      if diagnostic.message:find("Error: Could not find config file") then
        ---@diagnostic disable-next-line: return-type-mismatch
        return nil
      end
      return diagnostic
    end)

    local lint_augroup = vim.api.nvim_create_augroup("lint_code", { clear = true })
    local function lint_on_insert()
      local linters = vim.deepcopy(lint.linters_by_ft[vim.bo.filetype] or {})

      -- PHPStan analyzes the whole project, so do not run it while typing.
      linters = vim.tbl_filter(function(name)
        return name ~= "phpstan"
      end, linters)

      if #linters > 0 then
        lint.try_lint(linters)
      end
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint_on_insert()
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = lint_augroup,
      callback = function()
        -- Run all configured linters, including PHPStan, after saving.
        lint.try_lint()
      end,
    })
  end,
}
