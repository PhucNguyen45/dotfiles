" ============================================================================
" Vim Configuration
" ============================================================================

" Basic settings
set nocompatible
syntax enable
filetype plugin indent on

" Line numbers
set number
set relativenumber

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" UI
set cursorline
set showmatch
set showcmd
set wildmenu
set lazyredraw

" Colors
set t_Co=256
colorscheme desert

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Better splits
set splitbelow
set splitright

" Clipboard
set clipboard=unnamed

" Backup & undo
set nobackup
set nowritebackup
set noswapfile
set undodir=~/.vim/undodir
set undofile

" Keep 50 lines of command line history
set history=50

" Show the ruler
set ruler

" Status line
set laststatus=2
set statusline=
set statusline+=%F\ %m\ %r\ %y
set statusline+=%=
set statusline+=%l:%c\ (%p%%)

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" File type specifics
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType html,css,javascript,json setlocal tabstop=2 shiftwidth=2

" Leader key
let mapleader = " "

" Quick save
nnoremap <Leader>w :w!<CR>

" Quick quit
nnoremap <Leader>q :q<CR>

" Source vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>
