-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- reload current file
keymap.set({ "n", "v", "i" }, "<leader>lr", ":luafile %")

-- copy buffer to clipboard
keymap.set("n", "<leader>zz", ":w !cat | xclip -selection c <CR>")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- open terminal
keymap.set("n", "<leader>t", ":terminal<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- resizing windows
keymap.set("n", "<leader>sv>", "<C-w>>")
keymap.set("n", "<leader>sv<", "<C-w><")
keymap.set("n", "<leader>sh>", "<C-w>+")
keymap.set("n", "<leader>sh<", "<C-w>-")
