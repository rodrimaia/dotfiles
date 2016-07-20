inoremap jj <ESC>
let mapleader=","
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>
nmap <c-]> :tab tag <c-r><c-w><cr>
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set number      "show line numbers
set wrap        "dont wrap lines
"set linebreak   "wrap lines at convenient points
set mouse=a
set encoding=utf-8
set noruler
set ls=0 
set hidden
set autoread
set nospell
set expandtab
set tabstop=2
set shiftwidth=2
let g:indent_guides_enable_on_vim_startup = 0
set relativenumber
set undofile                " So is persistent undo ...
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
set backupdir=~/temp
set directory=~/temp
set undodir=~/temp
set autowrite                       " Automatically write a file when leaving
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit
set viewoptions=folds,options,cursor,unix,slash " Better Unix /
set virtualedit=onemore             " Allow for cursor beyond
set history=1000                    " Store a ton of history
set hidden                          " Allow buffer
set iskeyword-=.                    " '.' is an
set iskeyword-=#                    " '#' is
set iskeyword-=-                    " '-'
set foldlevelstart=20
set smartcase


call plug#begin()

Plug 'scrooloose/nerdtree'
map <C-e> :NERDTreeToggle<CR> %
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
let g:syntastic_html_tidy_ignore_errors = [ '<template> is not recognized!']

Plug 'scrooloose/nerdcommenter'

Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-s)

Plug 'dracula/vim'
syntax on
autocmd VimEnter * colorscheme dracula
Plug 'terryma/vim-multiple-cursors'

Plug 'airblade/vim-gitgutter'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

Plug 'kien/ctrlp.vim'

Plug 'rking/ag.vim'

Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 1

" Add plugins to &runtimepath
call plug#end()
