local map = require("core.utils").map
local opts = { silent = true, noremap = true }

-- NORMAL
-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map("n", "<C-s>", "<cmd>w<CR>", opts)
map("n", "<C-q>", "<cmd>q<CR>", opts)
map("n", "<ESC>", [[<C-\><C-n>]], opts)
-- Clear highlights
map("n", "<leader>h", "<cmd>nohlsearch<cr>", opts)
-- buffer navigation
map("n", "<A-Right>", "<cmd>bn<cr>", opts)
map("n", "<A-Left>", "<cmd>bp<cr>", opts)
-- Better Redo Option
map("n", "U", "<C-r>", opts)
-- For not yanking when deleting chars
map("n", "x", '"_x', opts)
-- Show/Unshow Relative line Numbers
map("n", "<leader>z", "<CMD>set invrnu invnu<CR>", opts)
-- For Easier Splitting of buffer
map("n", "<leader>|", "<C-w>v", opts)
map("n", "<leader>_", "<C-w>s", opts)

-- VISUAL
-- copy yank
map("v", "<C-c>", '"+y', opts)
-- Better paste
map("v", "p", '"_dP', opts)
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("n", "<F10>", "<cmd>term python % <cr>", opts)
