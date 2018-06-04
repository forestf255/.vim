" Don't try to be vi compatible
set nocompatible

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

let mapleader = ";"

" Better command line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Show relative line numbers
set number
set relativenumber

" Toggle relative line numbers
nnoremap <leader>r :call RelativeNumToggle()<cr>
function! RelativeNumToggle()
  if &relativenumber
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set textwidth=79
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" Specific format for pyhton files
autocmd BufNewFile,BufRead *.py
  \ set tabstop=4 shiftwidth=4 softtabstop=4

" Toggle line marker
nnoremap <leader>c :call MarkColumnToggle()<cr>
function! MarkColumnToggle()
  if &colorcolumn
    set colorcolumn=
  else
    set colorcolumn=80
  endif
endfunction

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
map <leader><space> :nohl<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
"Use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
colorscheme solarized

" Highlight trailing white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Native shortcuts
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>j :bn<cr>
map <leader>k :bp<cr>
map <leader>d :bd<cr>

:imap jk <Esc>

" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
else
  " Light / Dark Mode
  :command Dark set background=dark | colorscheme solarized | let g:lightline = { 'colorscheme': 'solarized' }
  :command Light set background=light | colorscheme default | let g:lightline = { 'colorscheme': 'default' } | call lightline#init() | call lightline#colorscheme() | call lightline#update()
endif

call plug#begin('~/.vim/plugged')
Plug 'jlanzarotta/bufexplorer'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
call plug#end()

" Change theme of light line bar
let g:lightline = { 'colorscheme': 'solarized' }

" Plugin shortcuts
if v:version < 800
  map <leader>n :Explore<cr>
  map <leader>o :ls<cr>
else
  map <leader>n :NERDTreeToggle<cr>
  map <leader>o :BufExplorer<cr>
  let g:ctrlp_map = '<c-f>'
endif

