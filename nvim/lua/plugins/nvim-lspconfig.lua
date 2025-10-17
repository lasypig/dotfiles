-- This is a custom function to handle the keywordprg option in Neovim
function MyKeywordprg()
  local keyword = vim.fn.expand("<cword>") -- Get the word under the cursor
  local man_command = ":Man " .. keyword
  local success, _ = pcall(vim.api.nvim_exec, man_command, true)
  if not success then
    vim.lsp.buf.hover()
  end
end

-- Set it as your keywordprg
-- vim.o.keywordprg = "lua MyKeywordprg()"

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'K', MyKeywordprg, opts)
end

return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local nvim_lsp = require'lspconfig'

			-- nvim_lsp.ccls.setup {
			-- 	cmd = { "ccls" };
			-- 	filetypes = { "cpp" };
			-- 	root_dir = nvim_lsp.util.root_pattern("compile_commands.json", ".git", ".ccls-cache");
			-- 	init_options = {
			-- 		highlight = {
			-- 			lsRanges = true;
			-- 		}
			-- 	};
			-- }

			--[[
			nvim_lsp.ltex.setup {
				cmd = { "ltex-ls" };
				filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" };
				root_dir = function()
					return vim.fn.getcwd()
				end;
				init_options = {
					highlight = {
						lsRanges = true;
					};
				};
				settings = {
					ltex = {
						language = "auto"
					}
				}
			}
			--]]



		end,
	}
}
