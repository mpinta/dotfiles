syntax on

set encoding=utf-8
set nu
set guicursor=
set nowrap
set noswapfile
set nobackup
set undofile
set undodir=~/.config/nvim/undodir
set colorcolumn=90
set noerrorbells
set relativenumber
set cursorline
set tabstop=4 softtabstop=4
set shiftwidth=4
" Tab to spaces
set expandtab
" Enable case sensitive search
set smartcase
" Better indent to new lines 
set smartindent
" Real time search results
set incsearch

" Plugins
call plug#begin()

Plug 'mbbill/undotree'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'

call plug#end()

" Set colorscheme
lua require('colorbuddy').colorscheme('gruvbuddy')
" Transparent cursor line
highlight CursorLine guibg=NONE ctermbg=NONE
" Transparent number line
highlight clear LineNr

" Window size
let netrw_winsize=25

" File tree settings
let g:netrw_browse_split=2
let g:netrw_banner=0

" Set leader key
let mapleader=' '

" Map hjkl to move between window splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Map undo tree 
noremap <leader>u :UndotreeShow<CR>

" Map file explorer 
noremap <leader>f :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

