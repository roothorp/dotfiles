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

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
		},
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		build = "make install_jsregexp",
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{
		"hrsh7th/nvim-cmp",
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
					["<CR>"] = cmp.mapping.confirm({ select = true }),
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
		end,
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			theme = "tokyonight",
		},
		config = function()
			require("lualine").setup({
				sections = {
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
				},
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			view = {
				width = 50,
			},
			renderer = {
				group_empty = true,
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
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
					"markdown",
					"markdown_inline",
					"query",
					"yaml",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
					},
				},
			})
		end,
	},
	{
		"romgrk/barbar.nvim",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			tabpages = true,
			clickable = true,
			icons = { filetype = { enabled = true } },
		},
		version = "^1.0.0",
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				go = { "golangcilint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{ "tpope/vim-sleuth" },
	{ "f-person/git-blame.nvim" },
	{ "vim-test/vim-test" },
	{ "sitiom/nvim-numbertoggle" },
	{
		"andythigpen/nvim-coverage",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("coverage").setup()
		end,
	},
	{ "mfussenegger/nvim-dap" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			require("dapui").setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end
	},
}, {
	ui = { border = "rounded" },
})
