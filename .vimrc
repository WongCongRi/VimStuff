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
Plugin 'w0rp/ale'
Plugin 'jceb/vim-hier'
set runtimepath+=~/.vim/plugin/smartcom.vim
set runtimepath+=~/.vim/plugin/foldsearches.vim
set runtimepath+=~/.vim/plugin/hlnext.vim

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
 
" vim-hier
highlight HierError    ctermfg=red     cterm=bold
highlight HierWarning  ctermfg=magenta cterm=bold

let g:hier_highlight_group_qf  = 'HierError'
let g:hier_highlight_group_qfw = 'HierWarning'

let g:hier_highlight_group_loc  = 'Normal'
let g:hier_highlight_group_locw = 'HierWarning'
let g:hier_highlight_group_loci = 'Normal'

" ALE
highlight AleError    ctermfg=red     cterm=bold
highlight AleWarning  ctermfg=magenta cterm=bold

augroup ALE_Autoconfig
    au!
    autocmd User GVI_Start  silent call Stop_ALE()
    autocmd User PV_Start   silent call Stop_ALE()
    autocmd User PV_End     silent call Start_ALE()
    autocmd User ALELint    silent HierUpdate
augroup END

let g:ale_set_loclist          = 0
let g:ale_set_quickfix         = 1
let g:ale_set_signs            = 0
let g:ale_linters              = { 'perl': ['perl'] }
let g:ale_perl_perl_executable = 'polyperl'
let g:ale_perl_perl_options    = '-cw -Ilib'

nmap ;m [Toggle automake on Perl files] :call Toggle_ALE()<CR>

function! Start_ALE ()
    ALEEnable
    HierStart
endfunction

function! Stop_ALE ()
    silent call s:ChangeProfile(&filetype)
    ALEDisable
    HierStop
    call setqflist([])
    redraw!
endfunction

function! Toggle_ALE ()
    if g:ale_enabled
        call Stop_ALE()
    else
        call Start_ALE()
    endif
    echo 'Error highlighting ' . (g:ale_enabled ? 'on' : 'off')
endfunction

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
set incsearch hlsearch ignorecase smartcase
set matchpairs+=<:>
 
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

" Set default window size
"if has("gui_running")
"	set lines=999 columns=999
"else
"	if exists("+lines")
"		set lines=50
"	endif
"	if exists("+columns")
"		set columns=150
"	endif
"endif

" Persistent Undo
if has('persistent_undo')
    set undolevels=1000
    set undodir=$HOME/.VIM_UNDO_FILES
    set undofile
endif

" Color
color custom

" ===================================================
