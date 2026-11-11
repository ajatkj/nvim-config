require('vim._core.ui2').enable({})
-- Makes loading standalone python3 files open faster
vim.g.python3_host_prog = "/usr/bin/python3"
local opt = vim.opt

-- allow securely loading of project level .nvimrc, .nvim.lua, .exrc
opt.exrc = true
opt.secure = true

-- recommended setting for auto-sessions plugin
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- setup for folds

vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.mouse = "a"

opt.number = true

-- Update title string in the same format as zsh plugin - `zsh-window-title`
-- i.e. parent_dir/current_dir - filename
local function set_titlestring()
  local filetype = vim.bo.filetype

  -- Get the current file path and directory information
  local filepath = vim.fn.expand("%:p")                       -- Full path to the file
  local filename = vim.fn.expand("%:t")                       -- Filename
  local current_dir = vim.fn.fnamemodify(filepath, ":p:h:t")  -- Current directory
  local parent_dir = vim.fn.fnamemodify(filepath, ":p:h:h:t") -- Parent directory
  -- Set the titlestring based on filetype
  if filetype == "neo-tree" or filetype == "oil" then
    ---@diagnostic disable-next-line: assign-type-mismatch
    opt.titlestring = current_dir .. "/Explorer"
  else
    ---@diagnostic disable-next-line: assign-type-mismatch
    -- opt.titlestring = parent_dir .. "/" .. current_dir .. " - " .. filename
    opt.titlestring = current_dir .. "/" .. filename
  end
end

-- Optionally, you can set an autocmd to call this function automatically when the filetype changes
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = set_titlestring,
})

-- Title is being updated by zsh plugin zsh-window-title
opt.title = true
-- opt.titlestring = '%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)'
opt.autoindent = true
opt.smartindent = true
opt.hlsearch = true
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true
opt.showcmd = true
opt.cmdheight = 0
opt.laststatus = 0
opt.expandtab = true
opt.scrolloff = 8
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true
opt.smarttab = true
opt.breakindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.wrap = false
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" })
opt.wildignore:append({ "*/node_modules/*" })
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "cursor"
opt.mouse = ""
opt.signcolumn = "yes:2"
opt.termguicolors = true
opt.guicursor = ""
opt.isfname:append("@-@")
vim.opt.winborder = 'rounded'


-- Add asterisks in block comments
opt.formatoptions:append({ "r" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.lsp.log.set_level("error")
