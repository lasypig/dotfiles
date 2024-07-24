return {
	{
		'WolfgangMehner/c-support',
		ft = { "c", "cpp", "h" },
		init = function()
			vim.g.C_MapLeader = '\\'
		end,
		config = function()
			vim.cmd([[
			nnoremap  <buffer>  <silent>  <A-j>       i<C-R>=C_JumpCtrlJ()<CR>
			inoremap  <buffer>  <silent>  <A-j>  <C-G>u<C-R>=C_JumpCtrlJ()<CR>
			""call mmtemplates#config#Add ( 'C', $HOME.'/.config/nvim/templates/c.templates' )
			""call mmtemplates#config#Add ( 'C', $HOME.'/.config/nvim/templates/personal.templates' )
			]])
		end
	}
}
