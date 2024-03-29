vim9script
# When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

# Use Vim settings, rather then Vi settings (much better!).
# This must be first, because it changes other options as a side effect.
set nocompatible

# allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		# always set autoindenting on
set history=50	# keep 50 lines of command line history
set ruler		# show the cursor position all the time
set showcmd		# display incomplete commands
set incsearch	# do incremental searching

# For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
# let &guioptions = substitute(&guioptions, "t", "", "g")

# Don't use Ex mode, use Q for formatting
map Q gq

# This is an alternative that also works in block mode, but the deleted
# text is lost and it only works for putting the current register.
#vnoremap p "_dp


if has("win32")
    $VIMFILES = $VIM.'/vimfiles'
    $V = $VIM.'/_vimrc'
else
    $VIMFILES = $HOME .. '/.vim'
    $V = $HOME .. '/.vimrc'
endif

# persistent undo
if has('persistent_undo')
	set undofile
	set undodir=$VIMFILES/.undodir
	set undolevels=1000
	set undoreload=10000
endif

# Switch syntax highlighting on, when the terminal has colors
# Also switch on highlighting the last used search pattern.
if has("gui_running")
  syntax on
  set hlsearch
  set lines=999 columns=999
endif

if has("gui_running")
  set guioptions-=m  #remove menu bar
  set guioptions-=T  #remove toolbar
  set guioptions-=r  #remove right-hand scroll bar
  set guioptions-=L  #remove left-hand scroll bar
endif

# Only do this part when compiled with support for autocommands.
if has("autocmd")

  # Enable file type detection.
  # Use the default filetype settings, so that mail gets 'tw' set to 72,
  # 'cindent' is on in C files, etc.
  # Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  # For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  # When editing a file, always jump to the last known cursor position.
  # Don't do it when the position is invalid or when inside an event handler
  # (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif # has("autocmd")

# set font
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set number
#set relativenumber
set cursorline
#set colorcolumn=80
#set cursorcolumn
set wildmenu
set lazyredraw
set showmatch
set nobackup
set nowb
set noswapfile
set listchars=tab:\¦\ ,extends:>,precedes:<

set hidden
runtime macros/matchit.vim
set wildmenu
set wildmode=list:longest

set ignorecase
set smartcase

set termguicolors

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set t_Co=256

#=========================
# VIM PLUG
#=========================
g:plug_window = 'new'
silent! call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'timakro/vim-searchant'
Plug 'Marfisc/vorange'
Plug 'vim-scripts/OmniCppComplete'
Plug 'cohama/lexima.vim'
Plug 'majutsushi/tagbar'
#Plug 'w0rp/ale'
Plug 'skywind3000/asyncrun.vim'
Plug 'vim-scripts/TagHighlight'
Plug 'leafgarland/typescript-vim'
#Plug 'yuttie/comfortable-motion.vim'
Plug 'zanglg/nova.vim'
Plug 'joshdick/onedark.vim'
Plug 'godlygeek/tabular'
Plug 'vim/colorschemes'
call plug#end()

if has("gui_running")
	set ambiwidth=double
	colorscheme onedark
	if has("win32")
		au GUIEnter * simalt ~x
		set guifont=Consolas\ Nerd\ Font:h10
		set clipboard=unnamed
	else
		au GUIEnter * call MaximizeWindow()
		#set guifont=Noto\ Mono\ 10
		set guifont=Consolas\ Nerd\ Font\ 10
	endif
else
	colorscheme onedark
endif

def MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
enddef


#=========================
# tagbar
#=========================
if !&diff
	leg autocmd FileType c,cpp,h,vim,py,lua nested :TagbarOpen
endif
g:tagbar_sort = 0

set tags=tags;
set autochdir

# encoding
# set encoding=cp936
# let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,gbk,cp936

# my map
map <F2> ggVG=

# NERDTree
g:NERDChristmasTree = 1
g:NERDTreeIgnore = ['\.d$', '\~$', '\.a$', '\.o$', 'tags$',] 
#NERDTreeMinimalUI = 1
g:NERDTreeDirArrows = 1
if !&diff
	leg au VimEnter * NERDTree
	leg au VimEnter * wincmd w
endif
nmap <F3> :NERDTreeToggle<CR><c-w>h
# close vim if the only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

# C-support 
 g:C_UseTool_doxygen = 'yes'

#=======================
# Alt+hjkl to jump win
#=======================
var c = 'a'
while c <= 'z'
  exec "set <A-" .. c .. ">=\e" .. c
  exec "imap \e" .. c .. " <A-" .. c .. ">"
  c = nr2char(1 + char2nr(c))
endwhile
set ttimeout ttimeoutlen=50

g:C_Ctrl_j = 'off'
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap zz :qall<Enter>
nnoremap <silent> zf zf%
nnoremap <silent> <a-left> <c-w><
nnoremap <silent> <a-right> <c-w>>

silent g:cur_term = system('ps -p $(ps -p $(ps -p $PPID -o ppid=) -o ppid=) o args=')
if g:cur_term =~ "gnome-terminal"
	set tgc
endif

g:DoxygenToolkit_blockHeader = "--------------------------------------------------------------------------"
g:DoxygenToolkit_blockFooter = "--------------------------------------------------------------------------"
g:DoxygenToolkit_authorName = "wangxb@hisome.com"
g:DoxygenToolkit_licenseTag = "Copyright @ HISOME"
g:DoxygenToolkit_commentType = "C"

# set pastetoggle=<F4>
vnoremap <F6> :Tabularize/=<CR>

set runtimepath+=~/.vim/ultisnips_rep

# status line ⮀⮂
g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'component': {
			\ 'readonly': '%{&readonly?"\u2b64":""}',
			\ },
		    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
		    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
			\ }

g:C_GuiSnippetBrowser = 'commandline'

# tmux
if exists('$TMUX')
	&t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	&t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
	set term=screen-256color
else
	&t_SI = "\<Esc>]50;CursorShape=1\x7"
	&t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

# Bind command to open vimrc file.
nnoremap <Leader>vc :e $MYVIMRC<CR>

# set the type of file without extention to txt
if strlen(&filetype) == 0
	set filetype=txt
endif

cmap w!! w !sudo  tee > /dev/null %

set path+=$PWD/**

# hilight the char @column 81 in c/h file
au BufWinEnter *.c,*.h w:m2 = matchadd('Search', '\%81v', -1)

if has("X11") && v:version > 703
	set clipboard=unnamedplus
endif

# Improved n/N - center line after page scroll
def Nice_next( cmd: string )
    var topline  = line('w0')
    var errmsg = ""
    execute "silent! normal! " .. cmd
    if errmsg =~ 'E38[45]:.*'
        echohl Error | unsilent echom errmsg | echohl None
        errmsg = ""
        return
    endif
    if topline != line('w0')
        normal! zz
    endif
enddef

nnoremap <silent> n :call <SID>Nice_next('n')<cr>
nnoremap <silent> N :call <SID>Nice_next('N')<cr>

#=========================
# OmniCppComplete
#=========================
g:OmniCpp_NamespaceSearch = 1
g:OmniCpp_GlobalScopeSearch = 1
g:OmniCpp_ShowAccess = 1 
g:OmniCpp_ShowPrototypeInAbbr = 1 # 显示函数参数列表 
g:OmniCpp_MayCompleteDot = 1   # 输入 .  后自动补全
g:OmniCpp_MayCompleteArrow = 1 # 输入 -> 后自动补全 
g:OmniCpp_MayCompleteScope = 1 # 输入 :: 后自动补全 
g:OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif 
set completeopt=menuone,menu,longest

#=========================
# Asynchronous Lint Engine
#=========================
filetype off
set runtimepath+=~/.vim/plugged/ale
g:ale_sign_warning = '->'
filetype plugin on
 
