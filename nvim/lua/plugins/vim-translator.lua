return {
	{
		'voldikss/vim-translator',
		init = function()
			vim.g.translator_default_engines = { 'bing', 'haici' }
			vim.api.nvim_set_keymap('n', "T", "<Plug>TranslateW", { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', "T", "<Plug>TranslateWV", { noremap = true, silent = true })
		end
	}
}
