return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		dependencies = { 
			'OXY2DEV/markview.nvim'
		},
		config = function()
			require'nvim-treesitter.configs'.setup({
				ensure_installed = { "c", "cpp", "lua", "rust"},
				sync_install = false,
				ignore_install = { "javascript" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				}
			})
		end,
	}
}
