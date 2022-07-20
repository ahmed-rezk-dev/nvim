local M = {}

M.setup = function()

local wk = require "which-key"

wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 2, 1, 4 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  ignore_missing = false,
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<space>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<space>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
-- see https://neovim.io/doc/user/map.html#:map-cmd
local vmappings = {
  ["/"] = { ":lua require('Comment.api').toggle_blockwise_op(vim.fn.visualmode())<CR>", "Comment" },
}
local mappings = {
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["n"] = { "<cmd>lua _NOTES_TOGGLE()<cr>", "Notes" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["a"] = { "<cmd>qa<CR>", "Quit All" },
  ["A"] = { "<cmd>qa!<CR>", "Quit All & Cancel" },
  ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },
  ["m"] = { "<cmd>MarkdownPreviewToggle<CR>", "Markdown Preview" },

  L = {
    "<cmd>:put =printf('console.log('' 🔔 %s 👉 %s 👉 %s:'', %s);', line('.'), expand('%:t'), expand('<cword>'), expand('<cword>'))<cr>",
    "Javascript Log",
  },

}

-- all of the mappings below are equivalent

-- method 2
wk.register(mappings, opts)
wk.register(vmappings, vopts)
end

return M