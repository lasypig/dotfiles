return {
	{
		'IMOKURI/line-number-interval.nvim',
		event = "VeryLazy",
		init = function()
			vim.g.line_number_interval_enable_at_startup = 1
			vim.g.line_number_interval = 10
		end,
		config = function()
			vim.api.nvim_set_hl(0, "DimLineNr", { link = "LineNr" })
			vim.api.nvim_set_hl(0, "HighlightedLineNr", {ctermfg=6,  fg="Cyan"})
		end
	}
}
