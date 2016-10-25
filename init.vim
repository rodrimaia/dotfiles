inoremap jj <ESC>
let mapleader=","
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
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

au BufNewFile,BufRead *.py " python PEP8 settings
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

call plug#begin()

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
let g:syntastic_html_tidy_ignore_errors = [ '<template> is not recognized!']

Plug 'godlygeek/tabular'

Plug 'scrooloose/nerdcommenter'

Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-s)


Plug 'flazz/vim-colorschemes'
"Plug 'daylerees/colour-schemes' ,{ 'rtp': 'vim/' }
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

Plug 'rking/ag.vim'
ca ag Ag!

Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 0
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40 
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

Plug 'jiangmiao/auto-pairs'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
let g:airline_theme='bubblegum'

" Add plugins to &runtimepath
call plug#end()
