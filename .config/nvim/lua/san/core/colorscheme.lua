-- colorscheme name
local colors = "onedark"

-- secure call to apply colorscheme
local status,_ = pcall( vim.cmd , "colorscheme " .. colors )
if not status then
  return
end
