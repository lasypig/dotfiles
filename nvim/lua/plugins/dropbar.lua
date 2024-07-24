return {
	{
		'Bekaboo/dropbar.nvim',
		--enabled = false,
		dependencies = {
			'nvim-telescope/telescope-fzf-native.nvim',
			'nvim-tree/nvim-web-devicons'
		},
		config = function()
			--require('nvim-web-devicons').setup({}),
			require('dropbar').setup({})
		end
	}
}
