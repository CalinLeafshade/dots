"    __             __     _               _      
"   / /  ___  __ _ / _|___| |__   __ _  __| | ___ 
"  / /  / _ \/ _` | |_/ __| '_ \ / _` |/ _` |/ _ \
" / /__|  __/ (_| |  _\__ \ | | | (_| | (_| |  __/
" \____/\___|\__,_|_| |___/_| |_|\__,_|\__,_|\___|
"
" Filename:   init.vim
" Github:     https://github.com/CalinLeafshade/dots/
" Maintainer: Steve Poulton (Calin Leafshade)

" Plugins {{{

call plug#begin('~/.config/nvim/plugged')

Plug 'sainnhe/everforest'
Plug 'sheerun/vim-polyglot'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'easymotion/vim-easymotion'

" Neovim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug '~/repos/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF


"}}}

" Colors {{{

syntax enable
filetype plugin on
set termguicolors
set background=dark
colorscheme everforest

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
set hidden

" }}}

" UI {{{

let mapleader=","
set number
set relativenumber
set modelines=1
set showcmd
set cursorline
set showmatch
set cmdheight=2
set signcolumn=yes
set updatetime=50
set shortmess+=c

:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <silent> <c-p> <Plug>(completion_trigger)
" }}}

" Searching {{{

set incsearch
set nohlsearch

" Scrolling 'border'
set scrolloff=10

" Center search results 
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"}}}

" Section Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax
nnoremap <space> za
" }}}

" Telescope {{{

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>


" }}}

" Commands {{{ 

augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap linebreak nolist
augroup END

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


" }}}

" Prettier {{{

let g:prettier#config#single_quote = "false"
let g:prettier#config#trailing_comma = "none"
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" }}}

" VIMRC {{{

nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>

" }}}

" vim:foldmethod=marker:foldlevel=0
