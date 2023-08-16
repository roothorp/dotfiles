local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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


require('lazy').setup({
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "storm"
        },
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true
    },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = "make install_jsregexp"
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            vim.opt.completeopt = { "menu", "menuone", "noselect" }
        
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end
    },
    { "saadparwaiz1/cmp_luasnip" },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            theme = "tokyonight"
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            view = {
                width = 50,
            },
            renderer = {
                group_empty = true,
            }
        },
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "bash",
                    "comment",
                    "git_rebase",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "gomod",
                    "gosum",
                    "json",
                    "lua",
                    "query",
                    "yaml",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'romgrk/barbar.nvim',
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            animation = true,
            tabpages = true,
            clickable = true,
            icons = { filetype = { enabled = true }},
        },
        version = '^1.0.0',
    },
    { "tpope/vim-sleuth" },
})
