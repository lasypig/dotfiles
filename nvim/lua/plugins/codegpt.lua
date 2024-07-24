return {
	{
		"dpayne/CodeGPT.nvim",
		ft = {'abc'},
		dependencies = {
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require("codegpt.config")
		end
	}
}
