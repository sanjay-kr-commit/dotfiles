local status , lsp_zero = pcall( require , "lsp-zero" ) 
if not status then
  return
end

-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
lsp_zero.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp_zero.nvim_workspace()

lsp_zero.setup()
