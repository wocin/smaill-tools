#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
echo '''
set autoindent
set softtabstop=4
set shiftwidth=4
set autoread 
set cindent
set showmatch 
set completeopt=longest,menu
set autochdir
set hlsearch

set encoding=utf8
syntax enable

set background=light
colorscheme solarized
"python
let g:pydiction_location='~/.vim/bundle/Pydiction/complete-dict'
let g:pydiction_menu_height=20
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:neocomplcache_enable_at_startup = 1

"The-NERD-Tree
map <F2> : NERDTreeMirror<CR>
map <F2> : NERDTreeToggle<CR>
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeShowBookmarks=1
let NERDTreeDirArrows=0

"For vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"vim-scripts repos
Bundle 'bash-support.vim'
Bundle 'perl-support.vim'
Bundle 'python.vim'
Bundle 'compilerpython.vim'
Bundle 'indentpython.vim'
Bundle 'python_match.vim'
Bundle 'Pydiction'
Bundle 'The-NERD-tree'
Bundle 'https://github.com/Lokaltog/vim-powerline.git'
Bundle 'https://github.com/altercation/vim-colors-solarized.git'
Bundle 'molokai'
filetype plugin indent on"
''' >~/.vimrc
mkdir ~/.vim/bundle -p
mkdir ~/.vim/colors -p