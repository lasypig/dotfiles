return {
	{

		'Shougo/deoplete.nvim',
		--enabled = false,
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g['deoplete#sources#clang#libclang_path'] = vim.g.clangso
			vim.g['deoplete#enable_at_startup'] = 1
			-- g['deoplete#disable_auto_complete'] = 1
			vim.cmd([[
			inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ check_back_space() ? "\<TAB>" :
			\ deoplete#mappings#manual_complete()
			function! s:check_back_space() abort "{{{
				let col = col('.') - 1
				return !col || getline('.')[col - 1]  =~ '\s'
				endfunction"}}}
				]])
		end
	}
}
