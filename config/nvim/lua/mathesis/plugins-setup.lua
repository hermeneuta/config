--auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	-- use("bluz71/vim-nightfly-guicolors")
	use("EdenEast/nightfox.nvim")

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- icons
	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocomplition
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Zen-mode
	use("folke/zen-mode.nvim") -- center your screen

	-- vimtex
	use("lervag/vimtex")

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- allow return to specific change
	use("mbbill/undotree")

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
	use("tpope/vim-fugitive")

	--rest.nvim
	use({
		"rest-nvim/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	})
	-- Nvim Obsidian
	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "mathesis",
						path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Mathesis",
					},
				},

				notes_subdir = "",

				-- Optional, customize how names/IDs for new notes are created.
				note_id_func = function(title)
					return title
				end,

				-- Optional, boolean or a function that takes a filename and returns a boolean.
				-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
				disable_frontmatter = true,

				-- Optional, alternatively you can customize the frontmatter data.
				note_frontmatter_func = function(note)
					-- This is equivalent to the default frontmatter function.
					local out = { tags = note.tags, created = os.date("%Y-%m-%d") }
					-- `note.metadata` contains any manually added fields in the frontmatter.
					-- So here we just make sure those fields are kept in the frontmatter.
					-- if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					-- 	for k, v in pairs(note.metadata) do
					-- 		out[k] = v
					-- 	end
					-- end
					return out
				end,

				templates = {
					subdir = "Templates",
					date_format = "%Y-%m-%d",
					time_format = "%H:%M",
					-- A map for custom variables, the key should be the variable and the value a function
					substitutions = {},
				},

				-- completion = {
				-- 	new_notes_location = "notes_subdir",
				-- 	use_path_only = true,
				-- 	prepend_note_id = false,
				-- 	prepend_note_path = false,
				-- },

				wiki_link_func = function(opts)
					return string.format("[[%s]]", opts.path)
				end,

				daily_notes = {
					folder = "Daily",
					template = "daily.md",
				},
			})
		end,

		-- Optional, for templates (see below).
	})
	-- vim-floaterm
	use("voldikss/vim-floaterm")

	-- harpoon 2
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- Vimwiki
	use({
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_list = {
				{
					path = "~/Documents/Documents/philosophy/wiki/",
					syntax = "markdown",
					ext = ".md",
				},
				{
					path = "~/CS/wiki/",
					syntax = "markdown",
					ext = ".md",
				},
				{
					path = "~/Portal/wiki/",
					syntax = "markdown",
					ext = ".md",
				},
			}
			vim.g.vimwiki_ext2syntax = {
				[".md"] = "markdown",
				[".markdown"] = "markdown",
				[".mdown"] = "markdown",
			}
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
