inoremap jj <ESC>
inoremap fd <ESC>
let mapleader=","
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>
map <CR> o<Esc>k
set t_BE=
"allow backspacing over everything in insert mode
"set backspace=indent,eol,start
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
"set relativenumber
set number      "show line numbers
set wrap        "dont wrap lines
"set linebreak   "wrap lines at convenient points
set mouse=a
set encoding=utf-8
set ruler
set ls=2
set hidden
set autoread
set nospell
set expandtab
set tabstop=2
set shiftwidth=2
let g:indent_guides_enable_on_vim_startup = 0
set undofile                " So is persistent undo ...
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
set backupdir=~/temp
set directory=~/temp
set undodir=~/temp
set autowrite                       " Automatically write a file when leaving
set shortmess+=a
set viewoptions=folds,options,cursor,unix,slash " Better Unix /
set virtualedit=onemore             " Allow for cursor beyond
set history=1000                    " Store a ton of history
set hidden                          " Allow buffer
set iskeyword-=.                    " '.' is an
set iskeyword-=#                    " '#' is
set iskeyword-=-                    " '-'
set foldlevelstart=20
set smartcase

au BufNewFile,BufRead *.py " python PEP8 settings
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4
      \ set textwidth=79
      \ set expandtab
      \ set autoindent
      \ set fileformat=unix

highlight htmlArg gui=bold
highlight htmlArg cterm=bold

" You'll be able to move selected block up/down in Visual block mode.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


cnoremap w!! w !sudo tee > /dev/null %

call plug#begin()

Plug 'github/copilot.vim'
Plug 'projekt0n/github-nvim-theme'
autocmd VimEnter * colorscheme github_light

Plug 'tpope/vim-sensible'

Plug 'dracula/vim'
syntax on
" autocmd VimEnter * colorscheme dracula

Plug 'scrooloose/nerdtree'
map <C-e> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$','^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
"Plug 'vim-syntastic/syntastic'
"let g:syntastic_html_tidy_ignore_errors = [ '<template> is not recognized!']
"let g:airline#extensions#syntastic#enabled = 1

Plug 'godlygeek/tabular'

Plug 'scrooloose/nerdcommenter'

Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-s)


"Fzf configuration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <D-p> :Files<CR>

" This is the default extra key bindings
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

Plug 'tpope/vim-fugitive'

Plug 'sheerun/vim-polyglot'

Plug 'stevearc/vim-arduino/'

"Plug 'ludovicchabant/vim-gutentags' 

" Add plugins to &runtimepath
"
call plug#end()

" reloads .vimrc -- making all changes active
map <silent> <Leader>v :source ~/dotfiles/init.vim<CR>:PlugInstall<CR>:bdelete<CR>:exe ":echo 'vimrc reloaded'"<CR>

" My Highlight Words
match Statement /then/
match Question /console.log/
