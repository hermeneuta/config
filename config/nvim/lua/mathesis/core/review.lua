local M = {}

function M.some_fun()
	print("hello!")
end

vim.api.nvim_set_keymap("n", "<leader>n", ":lua review.some_fun()<CR>", { noremap = true, silent = true })

return M
