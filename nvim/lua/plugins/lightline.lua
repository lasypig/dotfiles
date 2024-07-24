return {
	{
		'itchyny/lightline.vim',
		dependencies = { 'MaxSt/FlatColor' },
		init = function()
			vim.g.lightline = {
				colorscheme = 'flatcolor',
				mode_map = { c = 'NORMAL' },
				active = {
					left = { {'mode', 'paste' }, { 'fugitive', 'filename' }, { 'codeium' } },
				},

				component_function = {
					modified = 'shy#LightLineModified',
					readonly = 'shy#LightLineReadonly',
					fugitive = 'shy#LightLineFugitive',
					filename = 'shy#LightLineFilename',
					--fileformat = 'shy#MyFileformat',
					--filetype = 'shy#MyFiletype',
					fileencoding = 'shy#LightLineFileencoding',
					mode = 'shy#LightLineMode',
				},
				component = {
					codeium = '{…}%3{codeium#GetStatusString()}',
				},
				separator = { left = '', right = '' },
				subseparator = { left = '', right = '' }
			}
		end
	}
}
