return {
	{
		'voldikss/vim-floaterm',
		init = function()
			vim.g.floaterm_type = 'floating'
			vim.g.floaterm_width = 160
			vim.g.floaterm_height = 50
			vim.g.floaterm_winblend = 1
			vim.g.floaterm_position = 'center'
			vim.api.nvim_set_keymap('', '<F4>', ':FloatermToggle<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('!', '<F4>', '<Esc>:FloatermToggle<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('t', '<F4>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })
		end
	}
}
