-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- Set lualine as statusline
-- See `:help lualine.txt`
lualine.setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}
