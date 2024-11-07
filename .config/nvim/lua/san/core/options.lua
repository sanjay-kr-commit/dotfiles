local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split window
opt.splitright = true
opt.splitbelow = true

-- word configuration
opt.iskeyword:append("-")

opt.hlsearch = false 

opt.mouse = 'a'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Decrease update time
opt.updatetime = 250
opt.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- set shell to zsh if found
local zshPath = io.open("/usr/bin/zsh","r")
if zshPath ~= nil then
  opt.shell = "/usr/bin/zsh"
end
