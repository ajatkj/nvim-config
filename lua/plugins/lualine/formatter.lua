-- lua/user/lualine_conform.lua
local M = {}

-- 1) alias map (exact matches)
local FORMATTER_ALIASES = {
  -- ["prettierd"]  = "prettier",
  -- ["eslint_d"]   = "eslint",
}

-- 2) optional pattern aliases (if names vary; first match wins)
local FORMATTER_PATTERNS = {
  { pat = "^ruff.*$", alias = "ruff" }, -- collapses ruff*, e.g., ruff, ruff_fix, ruff_format
}

local function alias_of(name)
  local lower = string.lower(name)
  -- exact alias first
  if FORMATTER_ALIASES[lower] then
    return FORMATTER_ALIASES[lower]
  end
  -- then pattern aliases
  for _, entry in ipairs(FORMATTER_PATTERNS) do
    if lower:match(entry.pat) then
      return entry.alias
    end
  end
  return name
end

local function unique_preserve_order(list)
  local seen, out = {}, {}
  for _, item in ipairs(list) do
    if not seen[item] then
      seen[item] = true
      table.insert(out, item)
    end
  end
  return out
end

local function collapse_formatters(formatters)
  local mapped = {}
  for _, f in ipairs(formatters) do
    table.insert(mapped, alias_of(f))
  end
  return unique_preserve_order(mapped)
end

local function get_icon_and_color_for_ft(ft)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then return "", nil end

  local icon, color
  if devicons.get_icon_color_by_filetype then
    icon, color = devicons.get_icon_color_by_filetype(ft, { default = true })
  else
    local name  = vim.fn.expand("%:t")
    local ext   = vim.fn.expand("%:e")
    icon, color = devicons.get_icon_color(name, ext, { default = true })
  end
  return " ", color
end

function M.text()
  local ok, conform = pcall(require, "conform")
  if not ok then return "" end

  local buf = vim.api.nvim_get_current_buf()
  local fns = conform.list_formatters_for_buffer(buf)
  if not fns or vim.tbl_isempty(fns) then
    return ""
  end

  -- collapse + dedupe (e.g. "ruff_fix","ruff_check" -> "ruff")
  local display = collapse_formatters(fns)

  local ft = vim.bo[buf].filetype
  local icon = select(1, get_icon_and_color_for_ft(ft))
  return string.format("%s %s", icon, table.concat(display, " · "))
end

function M.color()
  local ft = vim.bo.filetype
  local _, color = get_icon_and_color_for_ft(ft)
  local c = { gui = "italic" }
  if color then c.fg = color end
  return c
end

function M.cond()
  local ok, conform = pcall(require, "conform")
  if not ok then return false end
  local fns = conform.list_formatters_for_buffer(0)
  return fns and not vim.tbl_isempty(fns)
end

return M
