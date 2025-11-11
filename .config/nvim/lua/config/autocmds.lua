-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local dirs = { "~/Documents/Obsidian/" }

    local is_snacks_explorer_open = function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        --        print("-- " .. ft)
        if ft:match("snacks_picker*") then
          return true
        end
      end
      return false
    end

    local cwd = vim.fn.expand("%:p:h")
    if cwd == nil then
      cwd = vim.fn.getcwd()
    end

    --    print(">> " .. cwd)

    if vim.bo.filetype:match("snacks_picker*") then
      --      print("   snacks explorer already open")
      --      print("")
      return
    end

    if is_snacks_explorer_open() then
      --      print("   snacks explorer already open")
      --      print("")
      return
    end

    for _, dir in ipairs(dirs) do
      --      print("   running " .. dir)
      if cwd:match(vim.fn.expand(dir) .. "*") then
        --        print("   " .. "match found : " .. dir)
        require("snacks").explorer({ cwd = cwd })
        --        print("")
        return
      end
    end
  end,
})
