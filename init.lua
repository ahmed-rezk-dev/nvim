require "plugins.index"
require "options"
require "utils.mappings"
require "utils.keymaps"
require "utils.autocommands"
require("lsp")
--[[ require("utils.tasks").runTypeCheckTasks() ]]
--[[ require('utils.job').jobstart({command = 'npm', args = {'start'}}) ]]

vim.cmd [[
  augroup typeCh
    autocmd!
    autocmd BufWritePost *.tsx  lua require("utils.tasks").runTypeCheckTasks() 
  augroup end
]]

vim.cmd [[


  " augroup strdr4605
  "   autocmd!
  "   autocmd FileType typescript,typescriptreact setlocal makeprg=./node_modules/.bin/tsc 
  "   " autocmd BufWritePost *.tsx  !make
  " augroup END

" setlocal makeprg=./node_modules/.bin/tsc\ \\\|\ sed\ 's/(\\(.*\\),\\(.*\\)):/:\\1:\\2:/'
" setlocal errorformat=%f:%l:%c:\ %t%n\ %m
"
" command! Makee silent lua require('utils.job').jobstart({command = 'npm', args = {'start'}})
" command! Ma silent lua require('utils.job').make()
" command! Makeee silent lua require'lsp.make'.localMake()
" command! Make silent lua require'lsp.make'.make()
" nnoremap <silent> <lader>m :Make<CR>
"
" augroup LintOnSave
"   autocmd! BufWritePost *.tsx,*.ts Make
" augroup END
]]


