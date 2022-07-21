local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins/index.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost index.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim"

    -- Helpers
    use "nvim-lua/plenary.nvim" -- require for LSP
    use { "ahmedkhalf/project.nvim", config = function() require("plugins._project").setup() end } -- Automagically cd to project directory using nvim lsp
    use { "rmagatti/auto-session", config = function() require("plugins._sessions").setup() end } -- sessions manager
    use { "rmagatti/session-lens",  requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" }, config = function() require("session-lens").setup() end } -- telescope sessions manager 
    use { "akinsho/toggleterm.nvim", config = function () require("plugins._toggleterm").setup() end } -- To persist and toggle multiple terminals 


    -- LSP
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "tamago324/nlsp-settings.nvim"
    use "jose-elias-alvarez/null-ls.nvim"

    -- Treesitter
    -- parser generator language syntax
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = function() require("plugins._treesitter").setup() end }

    -- cmp plugins
    use { "hrsh7th/nvim-cmp", config = function() require("plugins._cmp").setup() end }
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"
    use { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" }
    use { "onsails/lspkind.nvim" }
    use { "hrsh7th/cmp-nvim-lsp-signature-help" }

    -- snippets
    use { "L3MON4D3/LuaSnip" }
    use "rafamadriz/friendly-snippets"

    -- Lua interface plugins
    use { "kyazdani42/nvim-tree.lua", config = function() require("plugins._nvim-tree").setup() end } -- Files exploer
    use { "folke/which-key.nvim", config = function() require("plugins._whichkey").setup() end } -- shortcuts manager
    use { "akinsho/bufferline.nvim", config = function() require("plugins._bufferline").setup() end } -- Tabs/Buffers mananger
    use { "nvim-lualine/lualine.nvim", config = function() require("plugins._lualine").setup() end } -- Stauts button bar
    use { "nvim-telescope/telescope.nvim", config = function () require("plugins._telescope").setup() end } -- finder/ Searchings
    use { "goolord/alpha-nvim", config =function () require("plugins._alpha").setup() end } -- Dashboard window

    -- Themes/Colorsches
    use { "olimorris/onedarkpro.nvim", config = function() require("themes.onedarkPro").setup() end }

    -- Git
    use { "lewis6991/gitsigns.nvim", config = function() require("plugins._git").gitsignsSetup() end }
    use { "sindrets/diffview.nvim", config = function() require("plugins._git").diffviewSetup() end }
    use { "TimUntersberger/neogit", requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" }, config = function() require("plugins._git").neogitSetup() end }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
