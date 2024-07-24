return {
	{
		'HampusHauffman/block.nvim',
		config = function()
			require("block").setup({
				percent = 1.2,
				depth = 4,
				colors = nil,
				automatic = false,
				--        colors = {
					--            "#ff0000"
					--            "#00ff00"
					--            "#0000ff"
					--        }
				})
		end
	}
}
