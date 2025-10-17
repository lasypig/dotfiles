--With Nvim 0.12 this is a complete, working init.lua that provides 80% of what users want:

-- vim.pack.add{
--   'https://github. com/echasnovski/mini.completion',
--   'https://github. com/ibhagwan/fzf-lua',
--   'https://github. com/neovim/nvim-lspconfig',
-- }
-- require('mini.completion').setup{}
-- vim.lsp.enable('...')



-- ALIAS and functions
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local function keymap(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  keymap('n', shortcut, command)
end

local function imap(shortcut, command)
  keymap('i', shortcut, command)
end

local function vmap(shortcut, command)
  keymap('v', shortcut, command)
end

local function lua_system(command)
	local p = assert(io.popen(command));
	local s = assert(p:read("l"));
	p:close();
	return s;
end

-- allow backspacing over everything in insert mode
opt.backspace = {'indent','eol','start'}
opt.autoindent = true	-- always set autoindenting on
opt.history = 50        -- keep 50 lines of command line history
opt.ruler = true		-- show the cursor position all the time
opt.showcmd = true	    -- display incomplete commands
opt.incsearch = true	-- do incremental searching

--nmap("Q", "gq")

-- font settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.cursorline = true
vim.noexpandtab = true
opt.number = true
-- vim.wo.relativenumber = true
vim.wo.cursorline = true
-- opt.lazyredraw = true

-- opt.colorcolumn = 80
-- opt.cursorcolumn = true
opt.wildmenu = true
opt.showmatch = true
opt.jumpoptions = "view"
opt.bk = false
opt.wb = false
--opt.autowriteall = true
opt.swapfile = false
opt.hidden = true
opt.wildmenu = true
opt.wildmode = 'list:longest'
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'
opt.mouse = 'a'
opt.termguicolors = true
-- opt.shortmess -= 'S'
opt.tags = "tags"
--opt.winborder = "rounded"
opt.pumborder = "rounded"
opt.autochdir = true
opt.encoding = "utf-8"
opt.fileencodings = {'ucs-bom','utf-8','gbk','cp936'}
opt.path = opt.path + "$PWD/**"
opt.clipboard = "unnamedplus"

-- auto save
cmd([[autocmd BufHidden,FocusLost,WinLeave,CursorHold * if &buftype=='' && filereadable(expand('%:p')) | silent lockmarks update ++p | endif]])

vim.diagnostic.config({ virtual_text = { current_line = true } })

--opt.winbar = '%F'
opt.laststatus = 3
opt.mousescroll = 'ver:5,hor:2'
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

g.cur_term = lua_system('ps -p $(ps -p $(ps -p $PPID -o ppid=) -o ppid=) o args=')
g.clangpath = lua_system('llvm-config --libdir')
g.clangso = g.clangpath .. "/libclang.so"

vim.api.nvim_set_keymap('', "j", "(v:count == 0 ? 'gj' : 'j')", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('', "k", "(v:count == 0 ? 'gk' : 'k')", { noremap = true, silent = true, expr = true })

vmap('<LeftRelease>', '"*ygv')
nmap("zf", "zf%")
nmap("gs", ":%s//<Left>")
nmap("<space>", "za")
vmap("<space>", "za")

g.C_Ctrl_j = 'off'
nmap("<c-h>", "<C-w>h")
nmap("<c-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<c-l>", "<C-w>l")
nmap( "zz", ":wqall<Enter>")
nmap("<a-left>", "<c-w><")
nmap("<a-right>", "<c-w>>")

cmd([[filetype on]])
imap("<F1>", "<ESC>")

--  set the type of file without extention to log
if fn.strlen(vim.bo.filetype) == 0 then
	opt.filetype = "log"
end

keymap('', "<F2>", "ggVG=")
nmap("<Leader>vc", ":e $MYVIMRC<CR>")
nmap("t<CR>", ":below 20sp term://$SHELL<CR>i")
keymap('c', "w!!", "w !sudo tee > /dev/null %")

-- hilight the char @column 81 in c/h file
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
	pattern = {"*.c", "*.h"},
	command = "let w:m2=matchadd('Search', '\\%81v', -1)",
})

--  Improved n/N - center line after page scroll

function nice_next(cmd)
    local topline = vim.fn.line('w0')
    vim.cmd("silent! normal! " .. cmd)
    if topline ~= vim.fn.line('w0') then
        vim.cmd("normal! zz")
    end
end

vim.api.nvim_set_keymap('n', 'n', ':lua nice_next("n")<CR>', {silent=true})
vim.api.nvim_set_keymap('n', 'N', ':lua nice_next("N")<CR>', {silent=true})

if fn.has('nvim') == 1 then
	keymap('t', "<Esc>", "<C-\\><C-n>")
	keymap('t', "<C-h>", "<C-\\><C-n><C-w>h")
	keymap('t', "<C-j>", "<C-\\><C-n><C-w>j")
	keymap('t', "<C-k>", "<C-\\><C-n><C-w>k")
	keymap('t', "<C-l>", "<C-\\><C-n><C-w>l")
end

-- persistent undo
HOME = os.getenv("HOME")
if fn.has('persistent_undo') == 1 then
	opt.undofile = true
	opt.undodir = HOME .. "/.vim/.undodir"
	opt.undolevels = 1000
	opt.undoreload = 10000
end

cmd([[syntax on]])

----------------------------------------------------
--  load plugins
----------------------------------------------------
require("lazyinit")

if vim.g.neovide then
	opt.linespace=0
	opt.guifont = "Consolas Nerd Font:h10"
	--vim.g.neovide_fullscreen = true
else
	opt.listchars = { tab = '┆ ', extends = '>', precedes = '<' }
	if fn.has("gui_running") == 1 then
		opt.ambiwidth = "double"
		if fn.has("win32") == 1 then
			cmd([[au GUIEnter * simalt ~x]])
			opt.guifont = "Consolas:h10"
			opt.clipboard = "unnamed"
		else
			cmd([[au GUIEnter * call shy#MaximizeWindow()]])
			opt.guifont = "Consolas 11"
		end
	end
end


vim.g.webdevicons_conceal_nerdtree_brackets = 0

----------------------------------------------------
--  custom highlight
----------------------------------------------------
vim.api.nvim_set_hl(0, "Member", {ctermfg = 166, fg="#cb4b16"})
vim.api.nvim_set_hl(0, "myWhite", {ctermfg = 37, fg="#FFFFFF"})
vim.api.nvim_set_hl(0, "Type",      {ctermfg=35,  fg="Green"})
vim.api.nvim_set_hl(0, "Namespace", {ctermfg=14,  fg="#006bd2"})
vim.api.nvim_set_hl(0, "Typedef",   {ctermfg=166, bold=true, fg="#BBBB00"})
vim.api.nvim_set_hl(0, "AutoType",  {ctermfg=208, fg="#ff8700"})
vim.api.nvim_set_hl(0, "EnumConstant", {ctermfg=208, fg="#ff8700"})
vim.api.nvim_set_hl(0, "chromaticaCast",{ctermfg=35, fg="#719E07"})
vim.api.nvim_set_hl(0, "CopilotSuggestion", {fg="#555555", ctermfg=8})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {ctermfg=36,  fg="#008b8b"})

vim.api.nvim_set_hl(0, "@property.c", { link = "myWhite" })
vim.api.nvim_set_hl(0, "@variable.c", { link = "Debug" })
vim.api.nvim_set_hl(0, "@operator.c", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@constant.c", { link = "Macro" })
vim.api.nvim_set_hl(0, "@keyword.c", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "myWhite" })
vim.api.nvim_set_hl(0, "DimLineNr", { link = "LineNr" })

--vim.diagnostic.config({ virtual_text = true })

vim.lsp.inline_completion.enable(true)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.cmd("set completeopt+=noselect")

-- lua lsp config
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
vim.lsp.enable('lua_ls')


-- tex lsp config
vim.lsp.config('texlab', {
	settings = {
		texlab = {
			build = {
				executable = 'latexmk',
				args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
				onSave = true,
			},
			forwardSearch = {
				executable = 'zathura',
				args = { '--synctex-forward', '%l:1:%f', '%p' },
			},
			diagnosticsDelay = 300,
		}
	}
})

-- This is a custom function to handle the keywordprg option in Neovim
function MyKeywordprg()
  local keyword = vim.fn.expand("<cword>") -- Get the word under the cursor
  local man_command = ":Man " .. keyword
  local success, _ = pcall(vim.api.nvim_exec2, man_command, true)
  if not success then
    vim.lsp.buf.hover()
  end
end

--local nvim_lsp = require'lspconfig'

-- Set it as your keywordprg
-- vim.o.keywordprg = "lua MyKeywordprg()"

vim.lsp.enable('texlab')

-- clangd lsp config
vim.lsp.config('clangd',{
	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr }
		vim.keymap.set('n', 'K', MyKeywordprg, opts)
	end,
	cmd = { "clangd" };
	filetypes = { "c", "objc", "objcpp", "cpp" };
	root_markers = { 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git', 'TARGET.mk'};
	single_file_support = true;
})
vim.lsp.enable('clangd')

-- rust lsp config
vim.lsp.config('rust_analyzer', {
	cmd = { "rust-analyzer" };
	filetypes = { "rust" };
	root_markers = {"Cargo.toml", "rust-project.json"};
	settings = {
		["rust-analyzer"] = {}
	}
})
vim.lsp.enable('rust_analyzer')

vim.lsp.enable('ts_ls')
vim.lsp.enable('zk')

vim.lsp.config('pylsp',{
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
})
vim.lsp.enable('pylsp')

