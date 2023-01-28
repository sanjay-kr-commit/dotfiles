-- import neodev plugin safely
local status, neodev = pcall(require, "neodev")
if not status then
  return
end
-- Setup neovim lua configuration
neodev.setup()
