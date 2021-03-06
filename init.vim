
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
set mouse=a

silent let g:cur_term = system('ps -p $(ps -p $(ps -p $(ps -p $$ -o ppid=) -o ppid=) -o ppid=) o args=')
if g:cur_term =~ "gnome-terminal"
	set termguicolors
endif
if g:cur_term =~ "terminator"
	set termguicolors
endif
if  g:cur_term =~ "tmux"
	set termguicolors
endif

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap <silent> zf zf%
nnoremap <space> za
vnoremap <space> za

set t_Co=256
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
			\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
			\,sm:block-blinkwait175-blinkoff150-blinkon175

"======================================
" VIM PLUG
"======================================
let g:plug_window = 'new'
call plug#begin()
"Plug 'Xuyuanp/nerdtree-git-plugin'
if !exists('g:gui_oni')
    if g:cur_term !~ "sshd"
		Plug 'itchyny/lightline.vim'
	endif
	Plug 'scrooloose/nerdtree'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'lasypig/chromatica.nvim'
endif
if g:cur_term !~ "sshd"
Plug 'ryanoasis/vim-devicons'
endif
Plug 'timakro/vim-searchant'
Plug 'leafgarland/typescript-vim'
Plug 'lilydjwg/colorizer'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/libclang-python3'
Plug 'joshdick/onedark.vim'
Plug 'zanglg/nova.vim'
Plug 'WolfgangMehner/c-support'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'MaxSt/FlatColor'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'mattn/vim-maketable'
Plug 'mhinz/vim-lookup'
Plug 'tweekmonster/startuptime.vim'
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


"===========================
" tagbar
"===========================
if !&diff
	autocmd FileType c,cpp,h,vim,py,lua nested :TagbarOpen
endif
let g:tagbar_sort = 0

set tags=tags;
set autochdir

" encoding
set encoding=utf-8
" let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,gbk,cp936

" my map
map <F2> ggVG=

" NERDTree
if !exists('g:gui_oni')
	let NERDChristmasTree=1
	let NERDTreeIgnore=['\.d$', '\~$','\.a$','\.o$','tags$',] 
	"let g:NERDTreeDirArrowExpandable = '▶'
	"let g:NERDTreeDirArrowCollapsible = '▼ '
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
endif

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

" set the type of file without extention to txt
if strlen(&filetype) == 0
	set filetype=txt
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
" youdao dictionary
"===========================
vnoremap <silent> T :<C-u>Ydv<CR>
nnoremap <silent> T :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>

"===========================
" chromatica
"===========================
let g:diminactive_buftype_blacklist = []
let g:chromatica#libclang_path='/usr/lib/llvm-6.0/lib'
let g:chromatica#enable_at_startup=1
let g:chromatica#highlight_feature_level=1
let g:chromatica#responsive_mode=0
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
" Asynchronous Lint Engine
"===========================
filetype off
let &runtimepath.=',~/.config/nvim/plugged/ale'
filetype plugin on
let g:ale_sign_warning = '->'
let g:ale_linters = { 
			\ 'c': ['clang'],
			\}

"===========================
" nerdtree-syntax-highlight
"===========================
if !exists('g:gui_oni')
	let g:NERDTreeDisableExactMatchHighlight = 1
	let g:NERDTreeDisablePatternMatchHighlight = 1
endif

"===========================
" deoplete-clang
"===========================
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-6.0/clang'

"===========================
" vim-lookup
"===========================
autocmd FileType vim nnoremap <buffer><silent> <cr>  :call lookup#lookup()<cr>

