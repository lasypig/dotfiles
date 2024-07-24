return {
	{
		'echasnovski/mini.nvim',
		config = function()
			vim.g.minibase16_disable = true
			vim.g.minibufremove_disable = true
			vim.g.minicomment_disable = true
			vim.g.minicompletion_disable = true
			vim.g.minidoc_disable = true
			vim.g.minifuzzy_disable = true
			vim.g.minijump_disable = true
			vim.g.minimisc_disable = true
			vim.g.minisessions_disable = true
			vim.g.ministarter_disable = true
			vim.g.ministatusline_disable = true
			vim.g.minisurround_disable = true
			vim.g.minitabline_disable = true
			vim.g.minitrailspace_disable = true

			require('mini.indentscope').setup({});
			require('mini.pairs').setup({});
			require('mini.cursorword').setup({});
		end
	}
}
