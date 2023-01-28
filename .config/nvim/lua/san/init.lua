-- load plugins
if require("san.plugins-setup") then
  return
end
-- load colorscheme
require("san.core.colorscheme" )
-- load behavior configuration
require("san.core.options")
-- load keymaps
require("san.core.keymaps")
-- hightlight coppied line when yank is used
require("san.core.highlight_yank")
-- plugins setup for comment 
require("san.plugins.comment")
-- plugins setup for nvim-tree 
require("san.plugins.nvim-tree")
-- plugins setup for lualine
require("san.plugins.lualine")
-- plugins setup for treesitter 
require("san.plugins.treesitter")
-- plugins setup for gitsigns 
require("san.plugins.gitsigns")
-- show '|' for indents 
require("san.plugins.indent_blankline")
-- plugins setup for nvim-cmp
require("san.plugins.nvim-cmp2")
-- plugins setup for telescope
require("san.plugins.telescope")
-- plugins setup for neodev 
require("san.plugins.neodev")
-- plugins setup for fidget 
require("san.plugins.fidget")
-- configure lsp and install defailt servers 
require("san.plugins.lsp")
-- promt for installing appropriate server for opened file 
require("san.plugins.lsp_zero")
--require("san.plugins.code_runner")
