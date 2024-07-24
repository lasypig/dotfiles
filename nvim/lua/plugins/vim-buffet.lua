return {
	{
		'bagrat/vim-buffet',
		event = "VeryLazy",
		init = function()
			vim.g.buffet_powerline_separators = 1
			vim.api.nvim_set_keymap('n', "<leader>1", "<Plug>BuffetSwitch(1)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>2", "<Plug>BuffetSwitch(2)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>3", "<Plug>BuffetSwitch(3)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>4", "<Plug>BuffetSwitch(4)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>5", "<Plug>BuffetSwitch(5)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>6", "<Plug>BuffetSwitch(6)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>7", "<Plug>BuffetSwitch(7)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>8", "<Plug>BuffetSwitch(8)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>9", "<Plug>BuffetSwitch(9)", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "<leader>0", "<Plug>BuffetSwitch(10)", { noremap = true, silent = true })
		end
	}
}
