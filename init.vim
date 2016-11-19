
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
set lazyredraw

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

set ignorecase
set smartcase
set inccommand=nosplit

silent let g:cur_term = system('ps -p $(ps -p $(ps -p $(ps -p $$ -o ppid=) -o ppid=) -o ppid=) o args=')
if g:cur_term =~ "gnome-terminal"
	set termguicolors
endif

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap <silent> zf zf%
nnoremap <space> za
vnoremap <space> za

set t_Co=256

if has("gui_running")
	set ambiwidth=double
	colorscheme onedark
	if has("win32")
		au GUIEnter * simalt ~x
		set guifont=Consolas:h10
		set clipboard=unnamed
	else
		au GUIEnter * call MaximizeWindow()
		set guifont=Consolas\ 11
	endif
else
	colorscheme one
endif

function! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction


"===========================
" tagbar
"===========================
if !&diff
	autocmd FileType c,cpp,h,vim,py,lua nested :TagbarOpen
endif

set tags=tags;
set autochdir

" encoding
" set encoding=cp936
" let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,gbk,cp936

" my map
map <F2> ggVG=

" NERDTree
let NERDChristmasTree=1
let NERDTreeIgnore=['\.d$', '\~$','\.a$','\.o$','tags$',] 
let g:NERDTreeDirArrowExpandable = '▶'
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

" C-support 
let  g:C_UseTool_doxygen = 'yes'

function! TerminalAutoInsert()
	if &buftype ==# "terminal"
		startinsert
	endif
endfunction
autocmd WinEnter *  call TerminalAutoInsert()

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
function! s:nice_next(cmd)
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
" VIM PLUG
"======================================
let g:plug_window = 'new'
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'timakro/vim-searchant'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'lilydjwg/colorizer'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'lasypig/chromatica.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'joshdick/onedark.vim'
Plug 'WolfgangMehner/c-support'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'MaxSt/FlatColor'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
call plug#end()

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
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
	  \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
	  \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      \ }

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction


function! LightLineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
	return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
				\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
				\  &ft == 'unite' ? unite#get_status_string() :
				\  &ft == 'vimshell' ? vimshell#get_status_string() :
				\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
				\ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
		let branch = fugitive#head()
		return branch !=# '' ? '⭠ '.branch : ''
	endif
	return ''
endfunction

function! LightLineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

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
let g:chromatica#libclang_path='/usr/lib/llvm-3.9/lib'
let g:chromatica#enable_at_startup=1
let g:chromatica#highlight_feature_level=1
let g:chromatica#responsive_mode=0

"===========================
" YCM desn't support 32-bit system
"===========================
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
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

"===========================
" nerdtree-syntax-highlight
"===========================
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

