" Calin Leafshades nvim

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

Plug 'caksoylar/vim-mysticaltutor'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'tpope/vim-fugitive'
Plug 'digitaltoad/vim-pug'
Plug 'vim-airline/vim-airline'
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'

call plug#end()

"}}}

" Colors {{{

syntax enable
filetype plugin on
set termguicolors
colorscheme mysticaltutor
hi Normal ctermbg=none
hi Terminal ctermbg=none
hi Terminal guibg=none
hi Normal guibg=none

" }}}

" Tabs And Spaces {{{

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" }}}

" File Find {{{

set path+=**
set wildmenu
set wildignore+=**/node_modules/** 

" }}}

" UI {{{

let mapleader=","
set number
set relativenumber
set modelines=1
set showcmd
set cursorline
set showmatch

" }}}

" Searching {{{

set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

"}}}

" Section Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax
nnoremap <space> za   "Open and close folds
" }}}

" Commands {{{

command! MakeTags !ctags -R .

" }}}

" Prettier {{{

let g:prettier#config#single_quote = "false"
let g:prettier#config#trailing_comma = "none"
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" }}}

" Airline {{{

let g:airline_powerline_fonts = 1

"}}}

" VIMRC {{{

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" }}}

" vim:foldmethod=marker:foldlevel=0
