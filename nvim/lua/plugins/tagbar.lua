return {
	{
		'preservim/tagbar',
		ft = {'c', 'cpp', 'h', 'vim', 'py', 'lua'},
		init = function()
			if not vim.opt.diff:get()  then
				vim.api.nvim_create_autocmd({"FileType"}, 
				{ pattern = {'c', 'cpp', 'h', 'vim', 'py', 'lua'}, 
				command = ":TagbarOpen", nested = ture })
			end
			vim.g.tagbar_sort = 0
			vim.g.tagbar_type_c = {
				kinds = {
					'd:macros:1:0',
					'p:prototypes:1:0',
					'g:enums:1:0',
					'e:enumerators:1:0',
					't:typedefs:1:0',
					's:structs:1:0',
					'u:unions:1:0',
					'm:members:0:0',
					'v:variables:1:0',
					'f:functions',
					'?:unknown',
				}
			}
		end
	}
}
