set nocompatible
filetype off "For Vundle

" Vundle Setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/syntastic'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rhysd/vim-crystal'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'chriskempson/base16-vim'
Plugin 'tfnico/vim-gradle'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-ruby'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-sleuth'
Plugin 'kchmck/vim-coffee-script'

call vundle#end()

filetype plugin indent on

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
set shortmess+=c

" NERDTree
let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_autofind = 1
let g:NERDTreeMapOpenInTabSilent = '<2-LeftMouse>'

" map control-backspace to delete the previous word
" execute is hack to stop this being executed in intellij IDEA
execute 'inoremap <C-w> <C-\><C-o>dB'
execute 'inoremap <C-BS> <C-\><C-o>db'

" Always show powerline
set laststatus=2

" jk to exit insert mode
inoremap jk <ESC>
inoremap <ESC> <nop>
let g:multi_cursor_quit_key = 'jk'
let g:multi_cursor_insert_maps = {'j': 1}

syntax on

set encoding=utf-8

set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10

set shell=/bin/zsh

set expandtab
set shiftwidth=4
set softtabstop=4

autocmd Filetype yaml setlocal shiftwidth=2 softtabstop=2
autocmd Filetype ruby setlocal shiftwidth=2 softtabstop=2

set background=dark
colorscheme base16-3024

set number

set hlsearch
set incsearch
set ignorecase
set smartcase

set nobackup
set nowritebackup
set noswapfile
set guioptions-=m
set guioptions-=T

" Folding
set foldcolumn=1
au BufWinEnter * normal zR
let g:sh_fold_enabled = 3
let g:clojure_fold = 1
let perl_fold = 1
let php_folding = 1
let ruby_fold = 1
let g:tex_fold_enabled=1
let g:vimsyn_folding = 'aflmpPrt'
let g:xml_syntax_folding = 1
set foldmethod=syntax

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc nested so $MYVIMRC | if has('gui_running') && filereadable($MYGVIMRC) | so $MYGVIMRC | endif
augroup END

" Oh god...
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Ctrl-hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <esc> :noh<return><esc>
