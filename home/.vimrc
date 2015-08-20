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

call vundle#end()

filetype plugin indent on

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" map control-backspace to delete the previous word
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db

" Always show powerline
set laststatus=2

" jk to exit insert mode
inoremap jk <ESC>

syntax on

set encoding=utf-8

set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 10

set shell=/bin/zsh

set expandtab
set shiftwidth=2
set softtabstop=2

set background=dark
colorscheme base16-3024
