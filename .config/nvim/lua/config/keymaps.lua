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

-- softwrap button
--vim.keymap.set("n", "sw", function()
--  vim.opt.wrap = true
--  print(vim.opt.wrap)
--  vim.opt.wrap = false
--  print(vim.opt.wrap)
--end)

--
vim.keymap.set("n", "fa", function()
  require("config.sync_to_git")()
end)

vim.keymap.set("n", "fqa", function()
  require("config.sync_to_git")("sync")
end)

-- keymap to open link under cursor under qutebrowser
vim.keymap.set("n", "gxx", function()
  local url = vim.fn.expand("<cfile>")
  vim.cmd("!qutebrowser " .. url)
  vim.notify("Openned " .. url, vim.log.levels.INFO)
end)

-- keymap to open link under cursor under qwenview
vim.keymap.set("n", "gxxx", function()
  local url = vim.fn.expand("<cfile>")
  vim.cmd("!gwenview " .. url)
  vim.notify("Openned " .. url, vim.log.levels.INFO)
end)
-- open leetcode console
keymap.set("n", "<leader>lc", ":Leet console<CR>")
keymap.set("n", "<leader>ll", ":Leet lang<CR>")
keymap.set("n", "<leader>lc", ":Leet run<CR>")
keymap.set("n", "<leader>ls", ":Leet submit<CR>")

-- reload current file
keymap.set({ "n", "v" }, "<C-r>", ":set relativenumber<CR>")

-- reload current file
keymap.set({ "n", "v", "i" }, "<leader>lr", ":luafile %")

-- copy buffer to clipboard
keymap.set("n", "<leader>zz", ":w !cat | xclip -selection c <CR>")

-- show notification history
keymap.set("n", "<leader>snh", ":lua Snacks.notifier.show_history()<CR>")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- open terminal
keymap.set("n", "<leader>t", ":terminal<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- set filetype
keymap.set("n", "ft", ":set filetype=")
keymap.set("n", "jft", ":set filetype=java<CR>")

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
