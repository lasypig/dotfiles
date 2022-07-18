
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
set history=50	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching

map Q gq

" set font
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set number
"set relativenumber
set cursorline!
"set lazyredraw

"set colorcolumn=80
"set cursorcolumn
set wildmenu
set showmatch
set nobackup
set nowb
set noswapfile
set listchars=tab:\┆\ ,extends:>,precedes:<

set hidden
runtime macros/matchit.vim
set wildmenu
set wildmode=list:longest
vnoremap <LeftRelease> "*ygv

set ignorecase
set smartcase
set inccommand=nosplit
set mouse=nvi
"set shortmess-=S

set winbar=%F
set laststatus=3
set mousescroll=ver:5,hor:2

silent let g:cur_term = system('ps -p $(ps -p $(ps -p $PPID -o ppid=) -o ppid=) o args=')
silent let g:clangso = system('locate libclang.so | head -n1')
silent let g:clangpath = strpart(g:clangso, 0, strridx( g:clangso, '/' ))

set termguicolors

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap <silent> zf zf%
nnoremap gs :%s//<Left>
nnoremap <space> za
vnoremap <space> za

set t_Co=256
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
			\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
			\,sm:block-blinkwait175-blinkoff150-blinkon175

"if g:cur_term !~ "sshd"
"endif
"======================================
" VIM PLUG
"======================================
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
	if exists('g:gui_ond')
		set noruler
		set laststatus=0
		colorscheme onedark
	else
		colorscheme onedark
	endif
endif

let g:tex_flavor='xelatex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
"set conceallevel=1
"let g:tex_conceal='abdmg'

filetype on
"===========================
" tagbar
"===========================
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

lua << EOF
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
EOF

set tags=tags;
set autochdir

" encoding
set encoding=utf-8
" let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,gbk,cp936

" my map
map <F2> ggVG=

"===========================
" NERDTree
"===========================
let NERDChristmasTree=1
"let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeIgnore=['\.d$','\~$','\.lo','\.a$','\.o$','tags$'] 
"let g:NERDTreeDisableFileExtensionHighlight = 1
"let g:NERDTreeExtensionHighlightColor = {}
let g:NERDSpaceDelims = 1
if !&diff
	au VimEnter * NERDTree
	au VimEnter * wincmd w
endif
nmap <F3> :NERDTreeToggle<CR><c-w>h
" close vim if the only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" C-support 
let g:C_UseTool_doxygen = 'yes'
"let g:C_LocalTemplateFile = $HOME.'/.config/nvim/templates/Templates'
"let g:C_GlobalTemplateFile = $HOME.'/.config/nvim/templates/Templates'
"let g:C_CustomTemplateFile = $HOME.'/.config/nvim/templates/Templates'

autocmd WinEnter *  call shy#TerminalAutoInsert()

set ttimeout ttimeoutlen=50

let g:C_Ctrl_j = 'off'
nnoremap <c-h> <C-w>h
nnoremap <c-j> <C-w>j
nnoremap <c-k> <C-w>k
nnoremap <c-l> <C-w>l
map zz :qall<Enter>

nnoremap <silent> <a-left> <c-w><
nnoremap <silent> <a-right> <c-w>>

let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="wangxb@hisome.com"
let g:DoxygenToolkit_licenseTag="Copyright @ Hisome"
let g:DoxygenToolkit_commentType = "C"

" syntastic
let g:syntastic_check_on_open=1

" set pastetoggle=<F4>
vnoremap <F6> :Tabularize/=<CR>

set runtimepath+=~/.vim/ultisnips_rep
let g:C_GuiSnippetBrowser = 'commandline'

" Bind command to open vimrc file.
nnoremap <Leader>vc :e $MYVIMRC<CR>

" set the type of file without extention to log
if strlen(&filetype) == 0
	set filetype=log
endif

cmap w!! w !sudo  tee > /dev/null %

set path+=$PWD/**

" hilight the char @column 81 in c/h file
au BufWinEnter *.c,*.h let w:m2=matchadd('Search', '\%81v', -1)

set clipboard=unnamedplus

" Improved n/N - center line after page scroll
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

"======================================
" lightline settings
"======================================
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


" persistent undo
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.vim/.undodir
	set undolevels=1000
	set undoreload=10000
endif

"===========================
" chromatica
"===========================
"let g:diminactive_buftype_blacklist = []
"let g:chromatica#libclang_path=g:clangpath
"let g:chromatica#enable_at_startup=1
"let g:chromatica#highlight_feature_level=1
"let g:chromatica#responsive_mode=0
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

"===========================
" YCM desn't support 32-bit system
"===========================
let g:deoplete#enable_at_startup = 1
"let g:deoplete#disable_auto_complete = 1
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

"===========================
" nerdtree-syntax-highlight
"===========================
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

"===========================
" deoplete-clang
"===========================
let g:deoplete#sources#clang#libclang_path = g:clangso
"let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-6.0/clang'

"===========================
" vim-lookup
"===========================
autocmd FileType vim nnoremap <buffer><silent> <cr>  :call lookup#lookup()<cr>

"===========================
" vim-translator
"===========================
let g:translator_default_engines=['bing', 'haici']
nmap <silent> T <Plug>TranslateW
vmap <silent> T <Plug>TranslateWV

"===========================
" vim-floaterm
"===========================
let g:floaterm_type = 'floating'
let g:floaterm_width = 160
let g:floaterm_height = 50
let g:floaterm_winblend = 1
let g:floaterm_position = 'center'
noremap  <silent> <F4>    :FloatermToggle<CR>i
noremap! <silent> <F4>    <Esc>:FloatermToggle<CR>i
tnoremap <silent> <F4>    <C-\><C-n>:FloatermToggle<CR>

"===========================
"  line-number-interval.nvim
"===========================
let g:line_number_interval#enable_at_startup = 1
let g:line_number_interval = 10

"===========================
"  mini.nvim
"===========================
let g:minibase16_disable = v:true
let g:minibufremove_disable = v:true
let g:minicomment_disable = v:true
let g:minicompletion_disable = v:true
let g:minidoc_disable = v:true
let g:minifuzzy_disable = v:true
let g:minijump_disable = v:true
let g:minimisc_disable = v:true
let g:minisessions_disable = v:true
let g:ministarter_disable = v:true
let g:ministatusline_disable = v:true
let g:minisurround_disable = v:true
let g:minitabline_disable = v:true
let g:minitrailspace_disable = v:true
lua << EOF
require('mini.indentscope').setup({});
require('mini.pairs').setup({});
require('mini.cursorword').setup({});
EOF

"===========================
"  neovim-treesitter
"===========================
"lua << EOF
"require'nvim-treesitter.configs'.setup {
"  ensure_installed = { "c", "lua" },
"  sync_install = false,
"  ignore_install = { "javascript" },
"  highlight = {
"    enable = true,
"    additional_vim_regex_highlighting = false,
"  },
"}
"EOF

"===========================
"  nvim-lsp-installer
"===========================
lua << EOF
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
EOF
