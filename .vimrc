" File: .vimrc
" Author: Jan Waltl
" Description: My personal .vimrc
" Last Modified: July 28, 2020

"-------------------------------------------------------------------------------
" PLUGINS
"-------------------------------------------------------------------------------

" Automatic install of Vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Theme
Plug 'morhetz/gruvbox'
" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Parentheses and such
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" Easy motion jumps
Plug 'easymotion/vim-easymotion'
"Start screen with recent files
Plug 'mhinz/vim-startify'
" Fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
" Auto completion
" Filesystem tree viewer
Plug 'preservim/nerdtree'

call plug#end()

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Linting and such
" Plug 'dense-analysis/ale'
" C++ Semantic highlighting
" Plug 'jackguo380/vim-lsp-cxx-highlight'
" C/C++ Code formatting on save
" Plug 'Chiel92/vim-autoformat'
" Git on command line :G
" Plug 'tpope/vim-fugitive'
" Git commit browser with :GV
" Plug 'junegunn/gv.vim'
" Show git status for each line
" Can stage hunks interactively
" Plug 'airblade/vim-gitgutter'

" Plug 'vim-python/python-syntax'
" Plug 'heavenshell/vim-pydocstring'

"-------------------------------------------------------------------------------
" Autocommands
"-------------------------------------------------------------------------------

" Clear all autocommands
autocmd!
" Close Vim if NERDTree is the only window left open
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Format on save
"au BufWritePost * :Autoformat
" Update GitGutter sidebar on save
"au BufWritePost * :GitGutter

"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0

" Ultisnips triggers disabled
"let g:UltiSnipsExpandTrigger = "<NUL>"

" CUSTOM HIGHLIGHTING
" Source:
" https://vi.stackexchange.com/questions/19040/add-keywords-to-a-highlight-group
function! UpdateTodoKeywords(...)
    let newKeywords = join(a:000, " ")
    let synTodo = map(filter(split(execute("syntax list"), '\n') , { i,v -> match(v, '^\w*Todo\>') == 0}), {i,v -> substitute(v, ' .*$', '', '')})
    for synGrp in synTodo
        execute "syntax keyword " . synGrp . " contained " . newKeywords
    endfor
endfunction

augroup now
    autocmd!
    autocmd Syntax * call UpdateTodoKeywords("NOTE", "IMPROVE", "CONSIDER", "TODO", "FIXME", "WARNING", "PERFORMANCE", "OPTIMIZE")
augroup END

" Autocompletion settings - move with tab, confirm with enter
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"inoremap <expr> <tab>
  "\ pumvisible() ? "\<c-n>" : "\<tab>"
"inoremap <expr> <s-tab>
"  \ pumvisible() ? "\<c-p>" : "\<s-tab>"

"-------------------------------------------------------------------------------
" Options
"-------------------------------------------------------------------------------

set autoindent " Indent
set autoread " Automatically reload from disk
set backspace=indent,eol,start " Backspace deletes everything
set belloff=all " No bell
set bg=dark " Dark background
set breakindent "Broken lines are correctly indented
set breakindentopt=shift:2 "Broken lines are indented a little bti  more.
" Copy to/from system clipboard
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
else
    set clipboard=unnamed
endif
set colorcolumn=80,120 " Vertical lines for column widths
set completeopt=longest,menuone "
set cursorline " Highlight current line
set hidden " Allow hidden buffers
set hlsearch " Highlight search
set incsearch " Start search immedietelly
set mouse=a " Enable mouse
set number
set relativenumber " Show relative line numbers
set ruler
set scrolloff=10 " Start scrolling earlier when moving the cursors
set shiftwidth=4 "
set showbreak=+++ " Highlight long broken lines
set showmatch " Highlight matching braces
set splitbelow " Split below current window
set splitright " Split window to the right
set tabstop=4 " 4 spaces per tab
if !has('nvim')
	set ttymouse=xterm2
endif
set undodir="~/.vim/undodir"
set undofile " Enable persistent undo

"-------------------------------------------------------------------------------
" Colorscheme
"-------------------------------------------------------------------------------

let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='medium'
let g:gruvbox_termcolors=256
let g:gruvbox_italicize_strings=1
let g:gruvbox_italicize_comments=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1

" Enable syntax highlighting and gruvbox theme
"hi Normal guibg=NONE ctermbg=NONE
colorscheme gruvbox
syntax on

"-------------------------------------------------------------------------------
" Mappings
"-------------------------------------------------------------------------------

" Easier switching between modes
noremap ; :
noremap : ;
noremap ; :
noremap : ;
inoremap jk <ESC>

" Move down in "screen coordinates", not lines - usefull in case of wrapped
" lines.
nnoremap j gj
nnoremap k gk

" Disable exec mode, use it for running macros
nnoremap Q @q
" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"


" Move between splits
nnoremap <leader>h <C-w>h
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
nnoremap <leader>l <C-w>l
"              tabs
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
noremap gb gT
"             buffers
noremap <leader>] :bnext<cr>
noremap <leader>[ :bprev<cr>

" Clear highlights
noremap <C-L>  :nohls<CR><C-L>

" Open nerdtree
nnoremap <leader>t :NERDTreeToggle<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"				C/C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable debugger
" packadd! termdebug
" let g:termdebug_useFloatingHover = 1
" let g:termdebug_wide=1

" if has('nvim')
	" tnoremap <Esc> <C-\><C-n>
" endif


" let g:formattters_c = ['clang-format-11']

" let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp-cxx-hl.log'
"let g:lsp_cxx_hl_verbose_log = 1

" GoTo coc.nvim code navigation.
" Disable Vim's default go to definition
"nnoremap <silent> gd <Nop>
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
" Jump between diagnostics
"nmap <silent> gp <Plug>(ale_previous)
"nmap <silent> gn <Plug>(ale_next)

" Use c-K to show documentation in preview window.
"nnoremap <silent>  <c-k> :call <SID>show_documentation()<CR>

"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "else
    "call CocAction('doHover')
  "endif
"endfunction

" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Expand tabs into spaces
"autocmd FileType python setlocal softtabstop=4 expandtab

"let g:syntastic_python_python_exec = 'python3'
"let g:syntastic_python_checkers = ['flake8']

"let g:formatdef_autopep8 = "'autopep8 - -a -a'"
"let g:formatters_python = ['black']

"let g:python_highlight_all = 1

"let g:pydocstring_doq_path='~/.local/bin/doq'
"let pydocstring_formatter='numpy'
"let g:python_style='numpy'

" Generate docstring
"nmap <silent> <leader>dc <Plug>(pydocstring)

""""""""""" ALE """""""""""
"let g:ale_disable_lsp = 1
"let g:ale_open_list = 1
"let g:ale_completion_autoimport = 1
"let g:ale_linters = {'python':['flake8', 'pylint']}
"let g:ale_linters = {'python':['flake8','pylint','pydocstyle'],'cpp':['clang++']}
"let g:ale_python_auto_poetry= 1
"let g:ale_python_flake8_auto_poetry= 1
"let g:ale_python_black_auto_poetry= 1
"let g:ale_python_pylint_auto_poetry= 1
"let g:ale_python_pydocstyle_auto_poetry= 1

"let g:ale_c_build_dir_names = ['.', 'build']

"let g:airline#extensions#ale#enabled = 1

lua <<EOF
use {
  "neovim/nvim-lspconfig",
  opt = true,
  event = "BufReadPre",
  wants = { "nvim-lsp-installer" },
  config = function()
    require("config.lsp").setup()
  end,
  requires = {
    "williamboman/nvim-lsp-installer",
  },
}
EOF
