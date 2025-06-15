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
  local gitrepo = "~/projects/problem-solving/"

  if vim.fn.argc() == 0 then
    vim.notify("Not In leetcode.nvim mode", vim.log.levels.ERROR)
    return
  end
  if vim.fn.argv()[1] ~= "leetcode.nvim" then
    vim.notify("Not In leetcode.nvim mode", vim.log.levels.ERROR)
    return
  end

  local buffer = vim.api.nvim_buf_get_name(0)
  if buffer == nil or buffer == "" then
    vim.notify("Buffer is empty", vim.log.levels.ERROR)
    return
  end
  local ext = string.match(buffer, "%.([%w]+)$")
  local filename = string.match(buffer, "([^/]+)%.%w+$")

  if ext == nil or ext == "" then
    vim.notify("Extension is empty", vim.log.levels.ERROR)
    return
  end

  if filename == nil or filename == "" then
    vim.notify("Filename is empty", vim.log.levels.ERROR)
    return
  end

  local cwd = vim.fn.getcwd()

  if cwd == nil or cwd == "" then
    vim.notify("cwd is empty", vim.log.levels.ERROR)
    return
  end

  --local wins = vim.api.nvim_tabpage_list_wins(0) -- Get all windows in current tabpage
  --print("Number of open windows (splits): " .. #wins)
  local current_win = vim.api.nvim_get_current_win()
  local current_pos = vim.api.nvim_win_get_position(current_win) -- {row, col}
  local current_row, current_col = current_pos[1], current_pos[2]

  local wins = vim.api.nvim_tabpage_list_wins(0)
  local left_split_exists = false

  for _, win in ipairs(wins) do
    if win ~= current_win then
      local pos = vim.api.nvim_win_get_position(win)
      local row, col = pos[1], pos[2]
      -- Check if windows overlap vertically (same row) and window is left (smaller col)
      if row == current_row and col < current_col then
        left_split_exists = true
        break
      end
    end
  end

  if left_split_exists == false then
    vim.cmd("Leet desc toggle")
  end

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>h", true, false, true), "n", false)

  vim.cmd("w " .. gitrepo .. filename .. "/" .. "README.md")

  if left_split_exists == false then
    vim.cmd("Leet desc toggle")
  end

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>l", true, false, true), "n", false)

  vim.cmd(
    "split | terminal "
      .. "echo coppied readme "
      .. '&& echo "copying solution" '
      .. "&& cp "
      .. cwd
      .. "/"
      .. filename
      .. "."
      .. ext
      .. " "
      .. gitrepo
      .. filename
      .. "/solution"
      .. "."
      .. ext
      .. " "
      .. "&& cd "
      .. gitrepo
      .. " "
      .. "&& git pull "
      .. "&& git add "
      .. filename
      .. " "
      .. '&& git commit -m "'
      .. filename
      .. '"'
  )
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
