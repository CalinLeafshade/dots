" Calin Leafshades nvim

syntax enable
filetype plugin on

set number
set relativenumber

set path+=**
set wildmenu
set wildignore+=**/node_modules/** 

set shiftwidth=2
set tabstop=2
set expandtab

call plug#begin('~/.config/nvim/plugged')

Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'digitaltoad/vim-pug'

call plug#end()

command! MakeTags !ctags -R .

let g:prettier#config#single_quote = "false"
let g:prettier#config#trailing_comma = "none"

