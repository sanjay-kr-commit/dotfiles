local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

local function log_to_file(msg)
  local home = (os.getenv("HOME") or os.getenv("USERPROFILE"))
  --local log_path = vim.fn.stdpath("cache") .. "/my_plugin.log"
  local log_path = home .. "/neovim_custom.log"
  local f = io.open(log_path, "a")
  if f then
    f:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. msg .. "\n")
    f:close()
  end
end

return {
  log_to_file = log_to_file,
  mason_packages = mason_packages,
}
