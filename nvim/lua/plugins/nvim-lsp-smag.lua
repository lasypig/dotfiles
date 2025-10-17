return {
	{
		'lasypig/nvim-lsp-smag',
		enabled = false, -- nvim-lspconfig has this already
		init = function()
			vim.g.lsp_smag_fallback_tags = 1
		end
	}
}
