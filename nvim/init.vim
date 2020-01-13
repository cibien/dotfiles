set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-vdebug/vdebug'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
Plug 'yuttie/comfortable-motion.vim'
Plug 'sheerun/vim-polyglot'

call plug#end()            " required
filetype plugin indent on    " required

nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

let g:NERDTreeIgnore = ['^node_modules$']

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

if (has("termguicolors"))
  set termguicolors
endif

if !has('gui_running')
  set t_Co=256
endif

set background=dark
colorscheme palenight
set noshowmode
set autoindent
set smartindent
set expandtab
set tabstop=2
set smarttab
set shiftwidth=2

" coc.nvim {{ "
let g:coc_global_extensions = [
      \'coc-pairs',
      \'coc-json',
      \'coc-html',
      \'coc-tsserver',
      \'coc-eslint',
      \'coc-prettier',
      \'coc-highlight',
      \'coc-dictionary',
      \'coc-tag',
      \'coc-snippets',
      \'coc-lists',
      \'coc-yank',
      \'coc-yaml',
      \'coc-syntax',
      \'coc-git',
      \'coc-emoji',
      \'coc-calc',
      \'coc-xml',
      \'coc-marketplace',
      \'coc-webpack',
      \'coc-word',
      \'coc-lines',
      \'coc-markdownlint',
      \'coc-ecdict',
      \'coc-omnisharp',
      \]

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:palenight_terminal_italics=1

let g:lightline = {
  \   'colorscheme': 'palenight',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': ''
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
set laststatus=2
set cursorline
let mapleader = ","
" Sets an 8000ms (8s) timeout for key combinations beginning with the new <Leader> key, ','
set timeout timeoutlen=8000
" Gives Vim syntax highlighting
syntax on
" Gives Vim line numbers
set number nu
" Instead of emitting a bell sound on an erroneous input, make the screen flash
set visualbell
" Sets encoding to use Unicode utf-8 standard
set encoding=utf-8

" Show the column number in the status bar
set ruler
" Explicitly state that we don't need to be backwards-compatible with Vim's predecessor, vi
set nocompatible
" Enable mouse interactions in Normal mode - including resizing split windows
set mouse=n
set updatetime=100
" Search for any text fragment after typing the '/' key in Normal mode
set hlsearch
" Jump to next match found (if any) by pressing 'n'
set incsearch
" Sensible window navigation - navigate split window panes using <Leader> key and then one of WASD to move up, left, down, and right respectively
map <Leader>s :wincmd j<CR>
map <Leader>w :wincmd k<CR>
map <Leader>a :wincmd h<CR>
map <Leader>d :wincmd l<CR>
