local python_version = nil
local lazy = require("lazy.status")
-- Get python virtual env and python version
local function get_venv()
  local venv = os.getenv("VIRTUAL_ENV")
  if not venv then
    venv = os.getenv("CONDA_DEFAULT_ENV")
  end
  if venv ~= nil and string.find(venv, "/") then
    local orig_venv = venv
    for w in orig_venv:gmatch("([^/]+)") do
      venv = w
    end
    venv = string.format("%s", venv)

    -- Get Python version
    local version = python_version
    if version == nil then
      version = io.popen("python --version 2>&1"):read("*a")
      python_version = version
    end
    version = version:match("Python (%S+)")

    if version then
      venv = string.format("%s (%s)", version, venv)
    end
    -- else
    -- Get Python version
    -- local python_version = io.popen("python --version 2>&1"):read("*a")
    -- python_version = python_version:match("Python (%S+)")

    -- if python_version then
    -- local pyenv = io.popen("pyenv version-name 2>&1"):read("*a")
    -- if pyenv then
    -- venv = string.format("%s (pyenv)", python_version)
    -- else
    -- venv = string.format("%s", python_version)
    -- end
    -- end
  end
  return venv
end

-- Will only show up when the linter is actually "running" so for most cases it will
-- just show a tick mark
local lint_progress = function()
  local linters = require("lint").get_running()
  if #linters == 0 then
    return "󰦕"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end
local lsp_info = function()
  local lsps = vim.lsp.get_clients({ bufnr = vim.fn.bufnr() })
  local names = {}
  -- local ok, conform = pcall(require, "conform")
  -- local formatters = table.concat(conform.formatters_by_ft[vim.bo.filetype], " ")
  -- if ok then
  --   for formatter in formatters:gmatch("%w+") do
  --     if formatter then
  --       table.insert(names, formatter)
  --     end
  --   end
  -- end
  if lsps and #lsps > 0 then
    for _, lsp in ipairs(lsps) do
      table.insert(names, lsp.name)
    end
    return table.concat(names, "·")
  else
    return ""
  end
end

-- Show search result with count
local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  if searchcount.total == 0 then
    return ""
  end
  return last_search .. " (" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

local function search_no_result()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  if searchcount.total == 0 then
    return last_search .. " (No results)"
  end
  return ""
end

-- Show number of lines selected in visual block
local function selected_line()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "v" or mode == "V" then
    return "(" .. vim.fn.abs(vim.fn.line(".") - vim.fn.line("v")) + 1 .. ")"
  end
  return ""
end

local neo_tree_ext = {
  sections = {
    lualine_a = {
      {
        file_status = false,
        color = "lualine_a_normal",
        function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        separator = { right = "┃", left = "┃" },
      },
    },
  },
  filetypes = { "neo-tree" },
}
return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      extensions = { "quickfix", neo_tree_ext, "lazy", "fzf" },
      options = {
        -- theme = "kanagawa",
        ignore_focus = { "neo-tree" },
        component_separators = "",
        section_separators = { right = "┃", left = "┃" },
      },
      sections = {
        lualine_a = {
          { "mode", icons_enabled = true, separator = { right = "┃", left = "┃" } },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { "filename" },
          {
            function()
              -- local path = vim.fn.expand("%:~:.")
              local path = vim.fn.fnamemodify(vim.fn.expand("%:~:."), ":h")
              return path
            end,
            color = { fg = "yellow", gui = "italic" },
          },
        },
        lualine_x = {
          { search_result,    color = { fg = 106 } },
          { search_no_result, color = { fg = 203 } },
          {
            "encoding",
            cond = function()
              return vim.go.encoding ~= "utf-8"
            end,
          },
          {
            function()
              local venv = get_venv() or ""
              return venv
            end,
            cond = function()
              return vim.bo.filetype == "python"
            end,
          },
          -- Only show file format if it is not unix
          {
            "fileformat",
            cond = function()
              return vim.bo.fileformat ~= "unix"
            end,
          },
          { "filetype" },
          {
            require("plugins.lualine.formatter").text,
            color     = require("plugins.lualine.formatter").color,
            cond      = require("plugins.lualine.formatter").cond,
            -- optional: tweak separators/padding if you like
            separator = " ",
            padding   = 1,
          },
          {
            lsp_info,
            separator = { right = "┃", left = "┃" },
            on_click = function()
              vim.api.nvim_command("LspInfo")
            end,
            color = function()
              -- local ft = vim.api.nvim_buf_get_option(0, "filetype")
              local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
              local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(ft)
              if ft == "blade" then
                color = 203
              end

              return { fg = "white", bg = color }
            end,
          },
          { lint_progress },
        },
        lualine_y = {
          "progress",
          {
            function()
              -- return "ﮮ"
              return "󰚰 "
            end,
            cond = lazy.has_updates,
            -- color = { fg = colors.cyan },
          },
        },
        lualine_z = { { "location", icon = "" }, selected_line },
      },
    })
  end,
}
