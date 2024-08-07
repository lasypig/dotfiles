return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		config = function()
			require'nvim-treesitter.configs'.setup({
				ensure_installed = { "c", "lua", "rust"},
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
