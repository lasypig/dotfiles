return {
	{
		'tiagofumo/vim-nerdtree-syntax-highlight',
		config = function()
			vim.g.NERDTreeSyntaxEnabledExtensions = {'tex'}
			vim.g.NERDTreeExtensionHighlightColor = {h = "8FAA54", hh = "8FAA54", hpp = "8FAA54"}
		end
	}
}
