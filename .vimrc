syntax on

set encoding=utf-8
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set colorcolumn=80
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

" Fix color erase for 256-color teminal
set term=screen-256color

" Plugins
call plug#begin('~/.vim.plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-utils/vim-man'
Plug 'ycm-core/YouCompleteMe'
Plug 'mbbill/undotree'

call plug#end()

" Color scheme
colorscheme gruvbox
set background=dark

" Transparent background
" highlight Normal guibg=NONE ctermbg=NONE

" Transparent cursor line
 highlight CursorLine guibg=NONE ctermbg=NONE

" Transparent cursor line number
highlight CursorLineNr guibg=NONE ctermbg=NONE

" Set leader key
let mapleader=' '

" Window size
let netrw_winsize=25

" File tree settings
let g:netrw_browse_split=2
let g:netrw_banner=0

" Map hjkl to move between window splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Map undo tree 
noremap <leader>u :UndotreeShow<CR>

" Map file explorer 
noremap <leader>fe :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

