-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "gn", "<cmd>bnext<cr>")
map("n", "gp", "<cmd>bprevious<cr>")

map("n", "<C-t>", ":Neotree toggle<cr>")

map("n", "<F8>", ":TagbarToggle<CR>")

map("n", "<F4>", ":set spell<CR>")
map("n", "<F5>", ":set nospell<CR>")

map("n", "<space>ls", ":set textwidth=72<CR> :set colorcolumn=73<CR>")
map("n", "<space>ll", ":set textwidth=79<CR> :set colorcolumn=80<CR>")
