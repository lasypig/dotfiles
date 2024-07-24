return {
	{
		'preservim/nerdtree',
		enabled = false, -- use nvim-tree instead
		dependencies = {'tiagofumo/vim-nerdtree-syntax-highlight','ryanoasis/vim-devicons'},
		init = function()
			vim.g.NERDChristmasTree = 1
			-- let NERDTreeMinimalUI=1
			vim.g.NERDTreeDirArrows = 1
			vim.g.NERDTreeIgnore = {'\\.d$', '~$', '\\.lo', '\\.a$', '\\.o$', 'tags$'}
			-- let g:NERDTreeDisableFileExtensionHighlight = 1
			-- let g:NERDTreeExtensionHighlightColor = {}
			vim.g.NERDSpaceDelims = 1
			if not vim.opt.diff:get()  then
				vim.api.nvim_create_autocmd({"VimEnter"}, { command = ":NERDTree" })
				vim.api.nvim_create_autocmd({"VimEnter"}, { command = ":wincmd w" })
			end

			vim.api.nvim_set_keymap('n', "<F3>", "NERDTreeToggle<CR><c-w>h", { noremap = true, silent = true })
			--  close vim if the only window left open is a nerdtree
			vim.api.nvim_create_autocmd({"BufEnter"}, { 
					callback = function(ev)
						if vim.fn.tabpagenr('$') == 1 and vim.fn.winnr('$') == 1 then
							vim.cmd("if exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
						end
					end })
			vim.g.NERDTreeDisableExactMatchHighlight = 1
			vim.g.NERDTreeDisablePatternMatchHighlight = 1
		end
	}
}
