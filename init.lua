local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.g.mapleader = "`"
vim.wo.number = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300


if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        -- Directory nav
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }, 
    {
        -- File search
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
         dependencies = { 'nvim-lua/plenary.nvim' },
    }, {
        -- Lang parsing
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "cpp", "lua", "javascript", "html", "sql", "python", "typescript", "bash" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        -- Color theme
        "olimorris/onedarkpro.nvim",
        priority = 1000, -- Ensure it loads first
    },
    {
        -- Copilot
        "github/copilot.vim",
    },
    {
        -- Status line
        'nvim-lualine/lualine.nvim',
        opts = {},
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        -- Mason for LSP, formatters, and more
        "williamboman/mason.nvim",
        opts = {},
        lazy = false,
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason = require("mason")
            local mason_lspconfig = require("mason-lspconfig")

            mason.setup({
                ui = {
                    icons = {
                        package_installed = "",
                        package_pending = "...",
                        package_uninstalled = "",
                    }
                }
            })

            mason_lspconfig.setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "dockerls",
                    "gopls",
                    "html",
                    "jsonls",
                    "pyright",
                    "tsserver",
                    "vimls",
                    "yamlls",
                },
                automatic_installation = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        -- Commenting
        'numToStr/Comment.nvim',
        opts = { },
        lazy = false,
    },
    {
        -- Auto detect indent and tab
        'tpope/vim-sleuth'
    },
    { 
        -- Show pending keybinds
        'folke/which-key.nvim',
        opts = {}
    },
}, { lazy = true })
    


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Configure theme
vim.cmd("colorscheme onedark")

-- configure oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
