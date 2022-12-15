local M = {}

M.setup = function()
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    --[[ vim.keymap.set('n', 'zR', require('ufo').openAllFolds) ]]
    --[[ vim.keymap.set('n', 'zM', require('ufo').closeAllFolds) ]]
    --[[ vim.keymap.set('n', 'za', require('ufo').openFolds) ]]
   vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
        end
    })
end

return M
