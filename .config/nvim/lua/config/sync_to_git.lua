local gitrepo = "~/projects/problem-solving/"

return function(sync)
  if sync == nil then
    sync = false
  elseif sync ~= true or sync ~= false then
    sync = true
  end

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

  vim.cmd("w! " .. gitrepo .. filename .. "/" .. "README.md")

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
      .. (function()
        if sync then
          return "&& git pull "
        else
          return ""
        end
      end)()
      .. "&& git add "
      .. filename
      .. " "
      .. '&& git commit -m "'
      .. filename
      .. '"'
  )
end
