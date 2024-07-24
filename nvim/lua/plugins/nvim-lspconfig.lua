return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local nvim_lsp = require'lspconfig'

			--[[
			nvim_lsp.ccls.setup {
				cmd = { "ccls" };
				filetypes = { "c", "cpp", "objc", "objcpp" };
				root_dir = nvim_lsp.util.root_pattern("compile_commands.json", ".git", ".ccls-cache");
				init_options = {
					highlight = {
						lsRanges = true;
					}
				};
			}
			--]]

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

			nvim_lsp.rust_analyzer.setup {
				cmd = { "rust-analyzer" };
				filetypes = { "rust" };
				root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json");
				settings = {
					["rust-analyzer"] = {}
				}
			}

			nvim_lsp.clangd.setup {
				cmd = { "clangd-9" };
				filetypes = { "c", "cpp", "objc", "objcpp" };
				root_dir = nvim_lsp.util. root_pattern( '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git');
				single_file_support = true;
			}

			nvim_lsp.tsserver.setup{}

			nvim_lsp.pylsp.setup{
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = {'W391'},
								maxLineLength = 100
							}
						}
					}
				}
			}

		end,
	}
}
