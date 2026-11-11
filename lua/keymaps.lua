vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR><Esc>", { desc = "Clear search highlights", silent = true })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-y>", '"+y', { noremap = true })
vim.keymap.set("n", "<leader><space>", ":b#<CR>", { desc = "Toggle last buffer", noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { noremap = true, silent = true, desc = "Delete buffer" })
-- In visual mode, <leader>d deletes to the black hole register
-- vim.keymap.set("n", "<leader>z", function()
--   local search = vim.fn.getreg("/")
--   search = vim.fn.escape(search, "/\\")
--   vim.fn.setcmdline(":%s/" .. search .. "/")
-- end, { desc = "Substitute last search (prefilled)" })
vim.keymap.set("v", "<leader>d", '"_d', { noremap = true, silent = true })
-- replaces selected text WITHOUT losing what you yanked
vim.keymap.set("x", "p", [["_dP"]], { desc = "Paste over selection without losing yanked text" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word cursor is on globally" })

-- native undotree
vim.keymap.set("n", "<leader>u", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
