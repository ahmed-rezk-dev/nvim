vim.api.nvim_command "hi clear"
if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end
--[[ vim.o.background = "dark" ]]
vim.o.termguicolors = true
vim.g.colors_name = "custom"

local util = require "themes.custom.util"
Config = require "themes.custom.config"
C = require "themes.custom.palette"
local highlights = require "themes.custom.highlights"
local Treesitter = require "themes.custom.Treesitter"
local markdown = require "themes.custom.markdown"
local Whichkey = require "themes.custom.Whichkey"
local Git = require "themes.custom.Git"
local LSP = require "themes.custom.LSP"
local CMP = require "themes.custom.nvim_cmp"

local skeletons = {
  highlights,
  Treesitter,
  markdown,
  Whichkey,
  Git,
  LSP,
  CMP
}

for _, skeleton in ipairs(skeletons) do
  util.initialise(skeleton)
end
