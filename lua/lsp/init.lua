local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print "lspconfig Error"
  return
end

require "lsp.mason"
require("lsp.handlers").setup()
require "lsp.null-ls"
