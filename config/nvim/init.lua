require("mathesis.plugins-setup")
require("mathesis.core.options")
require("mathesis.core.keymaps")
local review = require("mathesis.core.review")
require("mathesis.core.colorscheme")
require("mathesis.plugins.comment")
require("mathesis.plugins.nvim-tree")
require("mathesis.plugins.lualine")
require("mathesis.plugins.telescope")
require("mathesis.plugins.nvim-cmp")
require("mathesis.plugins.lsp.mason")
require("mathesis.plugins.lsp.lspsaga")
require("mathesis.plugins.lsp.lspconfig")
require("mathesis.plugins.lsp.null-ls")
require("mathesis.plugins.autopairs")
require("mathesis.plugins.treesitter")
require("mathesis.plugins.gitsigns")
require("mathesis.plugins.zen-mode")
require("mathesis.plugins.vimtex")

vim.api.nvim_create_user_command("SomeFun", function()
	review.some_fun()
end, {})

vim.api.nvim_set_keymap(
	"n",
	"<leader>n",
	'<cmd>lua require("mathesis.core.review").some_fun()<CR>',
	{ noremap = true, silent = true }
)
