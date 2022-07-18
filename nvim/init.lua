-- ALIAS
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- allow backspacing over everything in insert mode
opt.backspace = indent,eol,start

opt.autoindent = true	-- always set autoindenting on
opt.history = 50        -- keep 50 lines of command line history
opt.ruler = true		-- show the cursor position all the time
opt.showcmd = true	    -- display incomplete commands
opt.incsearch = true	-- do incremental searching

nmap("Q", "gq") 

-- font settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
cmd([[set noexpandtab]])
opt.number = true
-- opt.relativenumber = true
cmd([[set cursorline!]])
-- opt.lazyredraw = true

-- opt.colorcolumn = 80
-- opt.cursorcolumn = true
opt.wildmenu = true
opt.showmatch = true
cmd([[set nobackup]])
cmd([[set nowb]])
cmd([[set noswapfile]])
cmd([[set listchars=tab:\┆\ ,extends:>,precedes:<]])

opt.hidden = true
cmd('runtime macros/matchit.vim')
opt.wildmenu = true
opt.wildmode = 'list:longest'
cmd('vnoremap <LeftRelease> "*ygv')

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'
opt.mouse = 'nvi'
-- opt.shortmess -= 'S'

opt.winbar = '%F'
opt.laststatus = 3
opt.mousescroll = 'ver:5,hor:2'

g.cur_term = os.execute('ps -p $(ps -p $(ps -p $PPID -o ppid=) -o ppid=) o args=')
g.clangso = os.execute('locate libclang.so | head -n1')
g.clangpath = fn.strpart(g.clangso, 0, fn.strridx( g.clangso, '/' ))

opt.termguicolors = true

cmd("noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')")
cmd("noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')")

nmap("zf", "zf%")
nmap("gs", ":%s//<Left>") 
nmap( "<space>", "za")
vmap("<space>", "za")

cmd([[set t_Co=256]])
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- VIM PLUG
cmd([[
let g:plug_window = 'new'
call plug#begin(stdpath('config') . '/plugged')
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
"Plug 'https://github.com/adelarsq/vim-devicons-emoji'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'timakro/vim-searchant'
"Plug 'leafgarland/typescript-vim'
"Plug 'lilydjwg/colorizer'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'codota/tabnine-vim'
Plug 'zchee/libclang-python3'
Plug 'joshdick/onedark.vim'
Plug 'zanglg/nova.vim'
Plug 'WolfgangMehner/c-support'
Plug 'echasnovski/mini.nvim'
Plug 'mileszs/ack.vim'
"Plug 'qpkorr/vim-bufkill'
Plug 'MaxSt/FlatColor'
Plug 'majutsushi/tagbar'
"Plug 'dense-analysis/ale'
Plug 'godlygeek/tabular'
Plug 'mattn/vim-maketable'
Plug 'mhinz/vim-lookup'
"Plug 'tweekmonster/startuptime.vim'
Plug 'lervag/vimtex'
Plug 'voldikss/vim-translator'
Plug 'voldikss/vim-floaterm'
Plug 'IMOKURI/line-number-interval.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'weilbith/nvim-lsp-smag'
Plug 'jackguo380/vim-lsp-cxx-highlight'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'liuchengxu/vista.vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'itchyny/landscape.vim'
Plug 'github/copilot.vim'
"Plug 'stevearc/dressing.nvim'
Plug 'mtdl9/vim-log-highlighting'
call plug#end()

if has("gui_running")
	set ambiwidth=double
	colorscheme onedark
	if has("win32")
		au GUIEnter * simalt ~x
		set guifont=Consolas:h10
		set clipboard=unnamed
	else
		au GUIEnter * call shy#MaximizeWindow()
		set guifont=Consolas\ 11
	endif
else
	colorscheme onedark
endif
]])

g.tex_flavor = 'xelatex'
g.vimtex_view_method = 'zathura'
g.vimtex_quickfix_mode = 0
-- opt.conceallevel = 1
-- g.tex_conceal = 'abdmg'

cmd([[filetype on]])
-- ===========================
--  tagbar
-- ===========================
cmd([[
if !&diff
   autocmd FileType c,cpp,h,vim,py,lua nested :TagbarOpen
endif
let g:tagbar_sort = 0
let g:tagbar_type_c = {
    \ 'kinds' : [
        \ 'd:macros:1:0',
        \ 'p:prototypes:1:0',
        \ 'g:enums:1:0',
        \ 'e:enumerators:1:0',
        \ 't:typedefs:1:0',
        \ 's:structs:1:0',
        \ 'u:unions:1:0',
        \ 'm:members:0:0',
        \ 'v:variables:1:0',
        \ 'f:functions',
        \ '?:unknown',
    \ ],
\ }
]])

local nvim_lsp = require'lspconfig'
nvim_lsp.ccls.setup {
    cmd = { "ccls" };
    filetypes = { "c", "cpp", "objc", "objcpp" };
    root_dir = nvim_lsp.util.root_pattern("compile_commands.json", ".git");
	init_options = {
		highlight = {
			lsRanges = true;
		}
	};
}
nvim_lsp.texlab.setup {
    cmd = { "texlab" };
    filetypes = { "tex" };
	init_options = {
		highlight = {
			lsRanges = true;
		}
	};
}

opt.tags = "tags"
opt.autochdir = true

--  encoding
opt.encoding = "utf-8"
--  let &termencoding=&encoding
opt.fileencodings = "ucs-bom,utf-8,gbk,cp936"

--  my map
cmd([[map <F2> ggVG=]])

-- ===========================
--  NERDTree
-- ===========================
cmd([[let NERDChristmasTree=1]])
-- let NERDTreeMinimalUI=1
cmd([[let NERDTreeDirArrows=1]])
cmd([[let NERDTreeIgnore=['\.d$','\~$','\.lo','\.a$','\.o$','tags$'] ]])
-- let g:NERDTreeDisableFileExtensionHighlight = 1
-- let g:NERDTreeExtensionHighlightColor = {}
g.NERDSpaceDelims = 1
cmd([[
if !&diff
	au VimEnter * NERDTree
	au VimEnter * wincmd w
endif
nmap("<F3>", ":NERDTreeToggle<CR><c-w>h") 
]])
--  close vim if the only window left open is a nerdtree
cmd([[autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif]])

--  C-support 
g.C_UseTool_doxygen = 'yes'
-- let g:C_LocalTemplateFile = $HOME.'/.config/nvim/templates/Templates'
-- let g:C_GlobalTemplateFile = $HOME.'/.config/nvim/templates/Templates'
-- let g:C_CustomTemplateFile = $HOME.'/.config/nvim/templates/Templates'

cmd([[autocmd WinEnter *  call shy#TerminalAutoInsert()]])

cmd([[set ttimeout ttimeoutlen=50]])

g.C_Ctrl_j = 'off'
nmap("<c-h>", "<C-w>h")
nmap("<c-j>", "<C-w>j")
nmap("<c-k>", "C-w>k")
nmap("<c-l>","<C-w>l")

nmap( "zz", ":qall<Enter>")
nmap("<a-left>", "<c-w><")
nmap("<a-right>", "<c-w>>")

g.DoxygenToolkit_blockHeader = "--------------------------------------------------------------------------"
g.DoxygenToolkit_blockFooter = "--------------------------------------------------------------------------"
g.DoxygenToolkit_authorName = "wangxb@hisome.com"
g.DoxygenToolkit_licenseTag = "Copyright @ Hisome"
g.DoxygenToolkit_commentType = "C"

--  syntastic
g.syntastic_check_on_open = 1

--  set pastetoggle=<F4>
vmap("<F6>", ":Tabularize/=<CR>")

cmd([[set runtimepath+=~/.vim/ultisnips_rep]])
g.C_GuiSnippetBrowser = 'commandline'

--  Bind command to open vimrc file.
cmd([[nnoremap <Leader>vc :e $MYVIMRC<CR>]])

--  set the type of file without extention to log
cmd([[
if strlen(&filetype) == 0
	set filetype=log
endif

cmap w!! w !sudo  tee > /dev/null %

set path+=$PWD/**

"hilight the char @column 81 in c/h file
au BufWinEnter *.c,*.h let w:m2=matchadd('Search', '\%81v', -1)
]])

opt.clipboard = "unnamedplus"

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

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
	tnoremap <c-h> <C-\><C-n><C-w>h
	tnoremap <c-j> <C-\><C-n><C-w>j
	tnoremap <c-k> <C-\><C-n><C-w>k
	tnoremap <c-l> <C-\><C-n><C-w>l
endif
nnoremap t<CR> :below 20sp term://$SHELL<CR>i
]])

-- ======================================
--  lightline settings
-- ======================================
cmd([[
let g:lightline = {
      \ 'colorscheme': 'flatcolor',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'shy#LightLineModified',
      \   'readonly': 'shy#LightLineReadonly',
      \   'fugitive': 'shy#LightLineFugitive',
      \   'filename': 'shy#LightLineFilename',
      \   'fileformat': 'shy#MyFileformat',
      \   'filetype': 'shy#MyFiletype',
      \   'fileencoding': 'shy#LightLineFileencoding',
      \   'mode': 'shy#LightLineMode',
      \ },
	  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
	  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }


"persistent undo
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.vim/.undodir
	set undolevels=1000
	set undoreload=10000
endif
]])

-- ===========================
--  chromatica
-- ===========================
-- let g:diminactive_buftype_blacklist = []
-- let g:chromatica#libclang_path=g:clangpath
-- let g:chromatica#enable_at_startup=1
-- let g:chromatica#highlight_feature_level=1
-- let g:chromatica#responsive_mode=0
cmd([[
hi Member    ctermfg=166 guifg=#cb4b16
hi Type      ctermfg=35  guifg=Green
hi Namespace ctermfg=14  guifg=#006bd2
hi Typedef   ctermfg=166 gui=bold guifg=#BBBB00
hi AutoType  ctermfg=208 guifg=#ff8700
hi EnumConstant        ctermfg=208 guifg=#ff8700
hi chromaticaException ctermfg=166 gui=bold guifg=#B58900
hi chromaticaCast      ctermfg=35  gui=bold guifg=#719E07
hi link chromaticaInclusionDirective cInclude
hi link chromaticaMemberRefExprCall  Type
hi CopilotSuggestion guifg=#555555 ctermfg=8
hi MiniIndentscopeSymbol ctermfg=36  guifg=#008b8b
]])

-- ===========================
--  YCM desn't support 32-bit system
-- ===========================
cmd([[let g:deoplete#enable_at_startup = 1]])
-- let g:deoplete#disable_auto_complete = 1
cmd([[
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ check_back_space() ? "\<TAB>" :
			\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
]])

-- ===========================
--  nerdtree-syntax-highlight
-- ===========================
g.NERDTreeDisableExactMatchHighlight = 1
g.NERDTreeDisablePatternMatchHighlight = 1

-- ===========================
--  deoplete-clang
-- ===========================
cmd([[let g:deoplete#sources#clang#libclang_path = g:clangso]])
-- let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-6.0/clang'

-- ===========================
--  vim-lookup
-- ===========================
cmd('autocmd FileType vim nnoremap <buffer><silent> <cr>  :call lookup#lookup()<cr>')

-- ===========================
--  vim-translator
-- ===========================
cmd("let g:translator_default_engines = ['bing', 'haici']")
nmap("T", "<Plug>TranslateW")
vmap("T", "<Plug>TranslateWV")

-- ===========================
--  vim-floaterm
-- ===========================
g.floaterm_type = 'floating'
g.floaterm_width = 160
g.floaterm_height = 50
g.floaterm_winblend = 1
g.floaterm_position = 'center'
cmd("noremap  <silent> <F4>    :FloatermToggle<CR>i")
cmd("noremap! <silent> <F4>    <Esc>:FloatermToggle<CR>i")
cmd([[tnoremap <silent> <F4>    <C-\><C-n>:FloatermToggle<CR>]])

-- ===========================
--   line-number-interval.nvim
-- ===========================
cmd([[let g:line_number_interval#enable_at_startup = 1]])
g.line_number_interval = 10

-- ===========================
--   mini.nvim
-- ===========================
g.minibase16_disable = true
g.minibufremove_disable = true
g.minicomment_disable = true
g.minicompletion_disable = true
g.minidoc_disable = true
g.minifuzzy_disable = true
g.minijump_disable = true
g.minimisc_disable = true
g.minisessions_disable = true
g.ministarter_disable = true
g.ministatusline_disable = true
g.minisurround_disable = true
g.minitabline_disable = true
g.minitrailspace_disable = true
require('mini.indentscope').setup({});
require('mini.pairs').setup({});
require('mini.cursorword').setup({});

-- ===========================
--   neovim-treesitter
-- ===========================
-- lua << EOF
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = { "c", "lua" },
--   sync_install = false,
--   ignore_install = { "javascript" },
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
-- }
-- EOF

-- ===========================
--   nvim-lsp-installer
-- ===========================
require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
