inoremap jj <ESC>
inoremap fd <ESC>
let mapleader=","
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>
"allow backspacing over everything in insert mode
set backspace=indent,eol,start
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

highlight htmlArg gui=bold
highlight htmlArg cterm=bold

" You'll be able to move selected block up/down in Visual block mode.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
Plug 'vim-syntastic/syntastic'
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

Plug 'ervandew/supertab'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
\]
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1


Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
let g:tern_show_argument_hints='on_hold'
" and 
let g:tern_map_keys=1

Plug 'honza/vim-snippets'
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

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
let g:ctrlp_show_hidden = 1

Plug 'jiangmiao/auto-pairs'

Plug 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0
Plug 'leshill/vim-json'

Plug 'editorconfig/editorconfig-vim'

Plug 'SirVer/ultisnips'
set runtimepath+=~/dotfiles/my-snippets

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
let g:airline_theme='bubblegum'



" TAGS:
Plug 'c0r73x/neotags.nvim'
let g:neotags_ctags_bin = 'ag -g "" '. getcwd() .' | ctags'
let g:neotags_ctags_args = [
            \ '-L -',
            \ '--fields=+l',
            \ '--c-kinds=+p',
            \ '--c++-kinds=+p',
            \ '--sort=no',
            \ '--extra=+q'
            \ ]
            "
Plug 'tpope/vim-surround'

Plug 'godlygeek/tabular'

Plug 'luochen1990/rainbow'

Plug 'airblade/vim-rooter'

Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/utl.vim'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" Add plugins to &runtimepath
call plug#end()

" My Highlight Words
match Statement /then/ 
match Question /console.log/ 

" PyEnv
let g:python_host_prog = '/Users/rmaia/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/rmaia/.pyenv/versions/neovim3/bin/python'

