-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<C-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer", remap = true })
map("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next Buffer", remap = true })

map("n", "<S-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<S-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
