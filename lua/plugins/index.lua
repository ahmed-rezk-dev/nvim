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

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
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

    -- Themes/Colorsches
    use { "olimorris/onedarkpro.nvim", config = function() require("themes.onedarkPro").setup() end }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
