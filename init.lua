local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.g.mapleader = "`"
vim.wo.number = true


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

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

require("lazy").setup({
    {
        -- Directory nav
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }, {
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
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        -- Mason for LSP, formatters, and more
        "williamboman/mason.nvim",
        opts = {},
        lazy = false,
    },
    {
        -- Commenting
        'numToStr/Comment.nvim',
        opts = { },
        lazy = false,
    }
}, { lazy = true })
    


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Configure theme
vim.cmd("colorscheme onedark")

-- Configure Mason
require("mason").setup()

-- Configure lualine
require('lualine').setup()
