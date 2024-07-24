return {
	{
		'mhinz/vim-lookup',
		ft = { 'vim' },
		init = function()
			vim.api.nvim_create_autocmd({"BufEnter"}, { pattern = {"*.vim"}, 
				command = "nnoremap <buffer><silent> <cr>  :call lookup#lookup()<cr>" })
		end
	}
}
