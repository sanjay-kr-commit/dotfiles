-- safe import
local status, fidget = pcall( require , "fidget" )
if not status then
  return
end

-- Turn on lsp status information
fidget.setup()
