require "plugins._lazy"
require "options"
require "plugins.init"
require "utils.mappings"
require "utils.keymaps"
require "utils.autocommands"
require("lsp.mason").setup()
require "lsp"
--[[ require("themes.colorscheme") ]]
require("utils.tasks").runTypeCheckTasks()
