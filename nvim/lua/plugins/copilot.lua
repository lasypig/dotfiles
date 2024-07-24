return {
	{
		'github/copilot.vim',
		ft = {'abcd'},
		config = function()
			vim.g.copilot_proxy = 'https://localhost:11435'
			vim.g.copilot_proxy_strict_ssl = false
		end
	}
}
