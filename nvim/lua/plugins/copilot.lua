return {
	{
		'github/copilot.vim',
		--ft = {'abcd'},
		config = function()
			--vim.g.copilot_proxy = 'https://localhost:11435'
			--vim.g.copilot_proxy_strict_ssl = false
			vim.keymap.set('i', '<Tab><Tab>', 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false
			})
			vim.g.copilot_no_tab_map = true
		end
	}
}
