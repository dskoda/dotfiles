set nocompatible " not vi compatible

" Vim-Plug
call plug#begin('~/.vim/plugged')

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'danilo-augusto/vim-afterglow'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tmhedberg/SimpylFold'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'dense-analysis/ale'

call plug#end()

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
set t_Co=256
set background=dark
let g:afterglow_blackout=1
colorscheme afterglow

filetype plugin indent on " enable file type detection
set autoindent
set encoding=utf-8

let mapleader = ","

" -------------------------
"  SimpylFold
" -------------------------

" Enable folding
nnoremap <Space> za
let g:SimpylFold_docstring_preview = 1


"---------------------
" Anaconda
"---------------------
if has('nvim') && !empty($CONDA_PREFIX)
  let g:python3_host_prog = $CONDA_PREFIX . '/bin/python'
endif

"---------------------
" Jedi-VIM
"---------------------
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#popup_on_dot = 0

"---------------------
" ALE syntax checker
"---------------------

let g:ale_linters = {'python': ['flake8']}
let b:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['isort', 'black']}

let g:ale_python_executable='python3'
let g:ale_python_flake8_use_global=1

" Disable whitespace warnings
let g:ale_warn_about_trailing_whitespace = 0
"
" Fix files when saving them
let g:ale_fix_on_save = 1

nmap <silent> <C-[> <Plug>(ale_previous_wrap)
nmap <silent> <C-]> <Plug>(ale_next_wrap)

"---------------------
" Basic editing config
"---------------------
set shortmess+=I " disable startup message
set nu " number lines
set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set lbr " line break
set ruler " show current position in file
set scrolloff=5 " show lines above and below cursor (when possible)
" set noshowmode " hide mode
set laststatus=2
set showcmd " show current command
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw " skip redrawing screen in some cases
set autochdir " automatically set current directory to directory of last opened file
set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/bufferss
set wildmode=longest,list,full
set wildmenu
set mouse+=a " enable mouse mode (scrolling, selection, etc)
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    if !has('nvim')
      set ttymouse=xterm2
    endif
endif

"--------------------
" Keybindings
"--------------------

" Keybindings


" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

" disable audible bell
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" break line
map <C-n> i<CR><Esc>

" save read-only files
command -nargs=0 Sudow w !sudo tee % >/dev/null

" clean search history
nnoremap <Leader><space> :noh<CR>

" paste mode
set pastetoggle=<Leader>p

"---------------------
" Local customizations
"---------------------

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

" nerdtree
filetype plugin indent on
map <Leader>t :NERDTreeToggle<CR>

" fzf
set rtp+=~/.fzf
map <Leader>f :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>g :GFiles<CR>

" Black neovim
nnoremap <Leader>k :Black<CR>
