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
opt.swapfile = false
opt.listchars = { tab = '┆ ', extends = '>', precedes = '<' }
opt.hidden = true
opt.wildmenu = true
opt.wildmode = 'list:longest'
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'
opt.mouse = 'nvi'
opt.termguicolors = true
-- opt.shortmess -= 'S'
cmd([[
set tags=tags;
set autochdir
]])
--opt.tags = "tags"
--opt.autochdir = true
opt.encoding = "utf-8"
opt.fileencodings = {'ucs-bom','utf-8','gbk','cp936'}
opt.path = opt.path + "$PWD/**"
opt.clipboard = "unnamedplus"

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
cmd([[
function! s:nice_next(cmd) abort
    let topline  = line('w0')
    let v:errmsg = ""
    execute "silent! normal! " . a:cmd
    if v:errmsg =~ 'E38[45]:.*'
        echohl Error | unsilent echom v:errmsg | echohl None
        let v:errmsg = ""
        return
    endif
    if topline != line('w0')
        normal! zz
    endif
endfun

nnoremap <silent> n :call <SID>nice_next('n')<cr>
nnoremap <silent> N :call <SID>nice_next('N')<cr>
]])

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
end

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

