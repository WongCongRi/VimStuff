set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" =============== Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" My Plugins
" ============================
Plugin 'scrooloose/nerdtree.git'
Plugin 'easymotion/vim-easymotion.git'
Plugin 'Lokaltog/vim-powerline.git'
Plugin 'vim-vdebug/vdebug.git'
Plugin 'zirrostig/vim-schlepp'
"Plugin 'https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/plugin/hlnext.vim'

" My Colors
" ===========================
"Plugin 'andreypopp/vim-colors-plain'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Remap arrow keys
no <down> <Nop>
no <left> :cprevious<CR>zz
no <right> :cnext<CR>zz
no <up> <Nop>
no <A-down> ddp
no <A-up> ddkP

" schlepp
vmap <up>    <Plug>SchleppUp
vmap <down>  <Plug>SchleppDown
vmap <left>  <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight

" Powerline
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
 
" Vdebug
if !exists('g:vdebug_options')
	let g:vdebug_options = {}
endif
let g:vdebug_options.port = 9001

" Custom stuff
set relativenumber
set number
set cursorline
set path+=**
set wildmenu
set showcmd
set mouse=a
set incsearch hlsearch ignorecase smartcase
 
" ========== Custom mappings ===========
inoremap jj <ESC>
let mapleader=','
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>
nmap <silent> <leader>n :NERDTree<CR>
nmap go o<ESC>k
nmap g<S-o> O<ESC>j
nmap n nzz
nmap N Nzz
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>' ()<ESC>i
imap {<Tab> {}<ESC>i<CR><ESC>:<1<CR>O
nmap <silent> <leader>sv :so ~/.vimrc<CR>
nmap <silent> <leader>ev :e ~/.vimrc<CR>
nmap <Space> <PageDown>
cnoremap *** **/*
nnoremap <silent> ,h :nohls<CR>
nnoremap v <C-v>
nnoremap <C-v> v

" Persistent Undo
if has('persistent_undo')
    set undolevels=1000
    set undodir=$HOME/.VIM_UNDO_FILES
    set undofile
endif

" Color
color custom

" ===================================================
