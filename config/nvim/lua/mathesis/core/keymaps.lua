vim.g.mapleader = " "

local keymap = vim.keymap
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "fa", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "fh", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hn", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>hp", function()
	harpoon:list():next()
end)

-- moving to next and previous buffer
keymap.set("n", "<C-n>", ":bn<CR>")
keymap.set("n", "<C-p>", ":bp<CR>")

-- j and k move between screen lines
keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

-- moving up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- pasting without affecting the unnamed register
keymap.set("x", "<leader>p", [["_dP]])

-- make file executable

keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- searching with cursor in place
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- general keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- zathura
keymap.set("n", "<leader>c", ":!zathura '%:r'.pdf &<CR><CR>:VimtexCompile<CR>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- tabs management
keymap.set("n", "to", ":tabnew<CR>") -- open new tab
keymap.set("n", "tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "tp", ":tabp<CR>") --  go to previous tab

-- plugin keymaps

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- snippets
keymap.set(
	"i",
	"=html",
	' <!DOCTYPE html> \n <html> \n <head> \n <meta charset="UTF-8" /> \n <meta name="viewport" content="width=device-width, initial-scale=1" /> \n <title>Tytuł</title> \n <link rel="stylesheet" href="css/main.css" /> \n <script src="js/main.css" defer></script> \n </head> \n <body> \n\n\n </body> \n </html>'
)

-- undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- fugitive
keymap.set("n", "<leader>gs", vim.cmd.Git)

-- vimwiki
keymap.set("n", "<leader>t", ":VimwikiTOC<CR>")

-- ZenMode
keymap.set("n", "<leader>z", ":ZenMode<CR>")

-- rest.nvim
keymap.set("n", "<leader>rr", "<Plug>RestNvim")
keymap.set("n", "<leader>RR", "<Plug>RestNvimPreview")

-- obsidian
keymap.set("n", "<leader>on", ":ObsidianNew<CR>")
keymap.set("n", "<leader>ot", ":ObsidianTemplate<CR>")
keymap.set("n", "<leader>od", ":ObsidianToday<CR>")
keymap.set("n", "<leader>oj", ":ObsidianToday +1<CR>")
keymap.set("n", "<leader>oy", ":ObsidianToday -1<CR>")
keymap.set("n", "<leader>occ", ":e CS. Index.md<CR>")
keymap.set("n", "<leader>ocl", ":e CS logs.md<CR>")
keymap.set("n", "<leader>ow", ":e week.md<CR>")
keymap.set("n", "<leader>om", ":e month.md<CR>")
keymap.set("n", "<leader>ol", ":%!o_links<CR>")
keymap.set("n", "<leader>of", ":e Filozofia.md<CR>")
keymap.set("n", "<leader>os", ":e Projects/Portal/Sztuka Cyrku.md<CR>")
keymap.set("n", "<leader>oa", ":e art.md<CR>")
keymap.set("n", "<leader>oh", ":e Harman. Index.md<CR>")
keymap.set("n", "ft", ":ObsidianTags ")

keymap.set(
	"n",
	"<leader>op",
	":ObsidianToday +1<CR>:vsp week.md<CR>:sp month.md<CR>:wincmd h<CR>:sp<CR>:ObsidianToday<CR>:wincmd k<CR>"
)
-- keymap.set("n", "<leader>om", ":e week.md<CR>")

-- macros
keymap.set("n", "Q", "@q")
keymap.set("x", "Q", ":norm @q<CR>")

-- lazygit
keymap.set("n", "<leader>lg", ":FloatermNew --width=0.8 --height=0.8 lazygit<CR>")
