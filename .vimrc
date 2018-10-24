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

" Auto-update this .vimrc file
" ============================
augroup VimReload
autocmd!
	autocmd BufWritePost $MYVIMRC so ~/.vimrc
augroup END

" My Plugins
" ============================
Plugin 'scrooloose/nerdtree.git'
Plugin 'easymotion/vim-easymotion.git'
Plugin 'Lokaltog/vim-powerline.git'
"Plugin 'vim-vdebug/vdebug.git'
Plugin 'zirrostig/vim-schlepp'
Plugin 'w0rp/ale'
Plugin 'jceb/vim-hier'
Plugin 'wongcongri/vim-stuff'

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

" custom stuff
" ===========================
set relativenumber
set number
set cursorline
set path+=**
set wildmenu
set showcmd
set incsearch hlsearch ignorecase smartcase
set matchpairs+=<:>

" Remap arrow keys
" ===========================
nnoremap <down> <Nop>
nnoremap <left>  :cprevious<CR>zz
nnoremap <right> :cnext<CR>zz
nnoremap <up> <Nop>
nnoremap <A-down> ddp
nnoremap <A-up> ddkP

" Color
" ===========================
set background=dark
color custom

" Initialize plugins
" ===========================
runtime bundle/vim-stuff/plugin/documap.vim
runtime bundle/vim-stuff/plugin/hlnext.vim
"runtime bundle/vim-stuff/plugin/foldsearches.vim

" schlepp
" ===========================
vnoremap <up>    <Plug>SchleppUp
vnoremap <down>  <Plug>SchleppDown
vnoremap <left>  <Plug>SchleppLeft
vnoremap <right> <Plug>SchleppRight

" Powerline
" ===========================
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
 
" vim-hier
" ===========================
let g:hier_highlight_group_qf  = 'HierError'
let g:hier_highlight_group_qfw = 'HierWarning'

let g:hier_highlight_group_loc  = 'Normal'
let g:hier_highlight_group_locw = 'HierWarning'
let g:hier_highlight_group_loci = 'Normal'

highlight HierError    ctermfg=33    cterm=bold guifg=#0087ff
highlight HierWarning  ctermfg=magenta cterm=bold guifg=#ff00ff

" ALE
" ===========================
highlight AleError    ctermfg=red cterm=bold guifg=#ff0000
highlight AleWarning  ctermfg=magenta cterm=bold guifg=#ff00ff

augroup ALE_Autoconfig
    au!
    autocmd User GVI_Start  silent call Stop_ALE()
    autocmd User PV_Start   silent call Stop_ALE()
    autocmd User PV_End     silent call Start_ALE()
    autocmd User ALELint    silent HierUpdate
augroup END

let g:ale_set_loclist          = 0
"let g:ale_set_quickfix         = 1
"let g:ale_set_signs            = 0
let g:ale_linters              = { 'perl' : ['perl'] }
let g:ale_linters              = { 'php': ['php'] }
"let g:ale_perl_perl_executable = 'polyperl'
let g:ale_perl_perl_options    = '-cw -Ilib'

Nmap ;m [Toggle automake on Perl files] :call Toggle_ALE()<CR>

function! Start_ALE ()
    ALEEnable
    HierStart
endfunction

function! Stop_ALE ()
"   silent call s:ChangeProfile(&filetype)
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

" Smartcom
runtime bundle/vim-stuff/plugin/smartcom.vim

let ANYTHING = ""
let NOTHING  = ""
let EOL      = '\s*$'

                " Left     Right      Insert                             Reset cursor
                " =====    =====      ===============================    ============
call SmartcomAdd( '<<',    ANYTHING,  "\<BS>\<BS>«"                                    )
call SmartcomAdd( '>>',    ANYTHING,  "\<BS>\<BS>»"                                    )
call SmartcomAdd( '?',     ANYTHING,  '?',                               {'restore':1} )
call SmartcomAdd( '?',     '?',       "\<CR>\<ESC>O\<TAB>"                             )
call SmartcomAdd( '{{',    ANYTHING,  '}}',                              {'restore':1} )
call SmartcomAdd( '{{',    '}}',      NOTHING,                                         )
call SmartcomAdd( 'qr{',   ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'qr{',   '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>"                 )
call SmartcomAdd( 'm{',    ANYTHING,  '}xms',                            {'restore':1} )
call SmartcomAdd( 'm{',    '}xms',    "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( 's{',    ANYTHING,  '}{}xms',                          {'restore':1} )
call SmartcomAdd( 's{',    '}{}xms',  "\<CR>\<C-D>\<ESC>O\<C-D>\<TAB>",                )
call SmartcomAdd( '\*\*',  ANYTHING,  '**',                              {'restore':1} )
call SmartcomAdd( '\*\*',  '\*\*',    NOTHING,                                         )

" Handle single : correctly...
call SmartcomAdd( '^:\|[^:]:',  EOL,  "\<TAB>" )

" In the middle of a keyword: delete the rest of the keyword before completing...
                " Left     Right                    Insert
                " =====    =====                    =======================
call SmartcomAdd( '\k',    '\k\+\%(\k\|\n\)\@!',    "\<C-O>cw\<C-X>\<C-N>",           )
call SmartcomAdd( '\k',    '\k\+\_$',               "\<C-O>cw\<C-X>\<C-N>",           )

"After an alignable, align...
function! AlignOnPat (pat)
    return "\<ESC>:call EQAS_Align('nmap',{'pattern':'" . a:pat . "'})\<CR>A"
endfunction
                " Left         Right        Insert
                " ==========   =====        =============================
call SmartcomAdd( '=',         ANYTHING,    "\<ESC>:call EQAS_Align('nmap')\<CR>A")
call SmartcomAdd( '=>',        ANYTHING,    AlignOnPat('=>') )
call SmartcomAdd( '\s#',       ANYTHING,    AlignOnPat('\%(\S\s*\)\@<= #') )
call SmartcomAdd( '[''"]\s*:', ANYTHING,    AlignOnPat(':'),                   {'filetype':'vim'} )
call SmartcomAdd( ':',         ANYTHING,    "\<TAB>",                          {'filetype':'vim'} )


                " Left         Right   Insert                                  Where
                " ==========   =====   =============================           ===================
" Perl keywords...
call SmartcomAdd( '^\s*for',   EOL,    " my $___ (___) {\n___\n}\n___",        {'filetype':'perl'} )
call SmartcomAdd( '^\s*if',    EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*while', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*given', EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*when',  EOL,    " (___) {\n___\n}\n___",                {'filetype':'perl'} )
call SmartcomAdd( '^\s*sub',   EOL,    " ___ (___) {\n___\n}\n___",            {'filetype':'perl'} )


" Convert between single- and double-quoted string endings...
call SmartcomAdd(      '''[^"]*"',  NOTHING,  "\<ESC>?'\<CR>:nohlsearch\<CR>r\"a",        {'restore':1+1} )
call SmartcomAdd( 'q\@<!q{[^"]*"',  NOTHING,  "\<BS>}\<ESC>?q{\<CR>:nohlsearch\<CR>sqq",  {'restore':1+2} )
call SmartcomAdd(     '"[^'']*''',  NOTHING,  "\<ESC>?\"\<CR>:nohlsearch\<CR>r'a",        {'restore':1+1} )
call SmartcomAdd(   'qq{[^'']*''',  NOTHING,  "\<BS>}\<ESC>?qq{\<CR>:nohlsearch\<CR>2sq", {'restore':1+1} )

" Vdebug
if !exists('g:vdebug_options')
	let g:vdebug_options = {}
endif
let g:vdebug_options.port = 9001
 
" ========== Custom mappings ===========
"let mapleader=','
inoremap jj <ESC>
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>
Nmap ;n [Open NERDTree] :NERDTree<CR>
nmap go o<ESC>k
nmap g<S-o> O<ESC>j
nmap n nzz
nmap N Nzz
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>' ()<ESC>i
imap {<Tab> {}<ESC>i<CR><ESC>:<1<CR>O
Nmap ;l [Reload .vimrc] :so ~/.vimrc<CR>
Nmap ;v [Edit .vimrc] :next $MYVIMRC<CR>
nmap <Space> <PageDown>
cnoremap *** **/*
nnoremap v <C-v>
nnoremap <C-v> v
Nmap ;g [Grep under word] :vim /<C-R><C-W>/ **/*<CR>
Nmap ;G [Grep under word with edit] :vim /<C-R><C-W>/ **/*

" Delete in normal mode to switch off highlighting till next search and clear messages...
" ===========================
"Nmap <silent> <BS> [Cancel highlighting] :call HLNextOff() <BAR> :nohlsearch <BAR> :call VG_Show_CursorColumn('off')<CR>::HierClear<CR>
Nmap <silent> <BS> [Cancel highlighting] :call HLNextOff() <BAR> :nohlsearch <CR>::HierClear<CR>

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
" ===========================
if has('persistent_undo')
    set undolevels=1000
    set undodir=$HOME/.VIM_UNDO_FILES
    set undofile
endif

" ===================================================
