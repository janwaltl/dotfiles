" File: .vimrc
" Author: Jan Waltl
" Description: My personal .vimrc
" Last Modified: July 28, 2020

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
" Plug 'ctrlpvim/ctrlp.vim'
" Python
Plug 'vim-python/python-syntax'
Plug 'heavenshell/vim-pydocstring'
" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Linting and such
Plug 'dense-analysis/ale'
" C++ Semantic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'
" C/C++ Code formatting on save
Plug 'Chiel92/vim-autoformat'
" Git on command line :G
Plug 'tpope/vim-fugitive'
" Git commit browser with :GV
Plug 'junegunn/gv.vim'
" Show git status for each line
" Can stage hunks interactively
Plug 'airblade/vim-gitgutter'
" Filesystem tree viewer
Plug 'preservim/nerdtree'

" Golang
call plug#end()


set completeopt=longest,menuone
"4-width tabs
set tabstop=4
set shiftwidth=4
" Vertical lines for column widths
set colorcolumn=80,120
set ruler
" Highlight the broken line
set showbreak=+++
" What can  backspace delete
set backspace=indent,eol,start
" Start search immedietelly and highlight it
set incsearch
set hlsearch

set cursorline

" Highlight matching braces
set showmatch
" Show relative line numbers
set number
set relativenumber
" Start scrolling earlier when moving the cursors
set scrolloff=10

" Enable persistent undo
set undofile
set undodir="~/.vim/undodir"

set splitbelow
set mouse=a
" Allow hidden buffers
set hidden
" Easier switching between modes
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
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
:noremap <C-L>  :nohls<CR><C-L>


" Highlights the current line in the insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Enable syntax highlighting and gruvbox theme
syntax enable

let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='medium'
let g:gruvbox_termcolors=256
let g:gruvbox_italicize_strings=1
let g:gruvbox_italicize_comments=1

hi Normal guibg=NONE ctermbg=NONE
colorscheme gruvbox
set bg=dark


let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='badwolf'

"Add Syntastic to airline
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:airline_powerline_fonts = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Format on save
au BufWrite * :Autoformat
" Update GitGutter sidebar on save
au BufWrite * :GitGutter

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

" Ultisnips triggers
" DISABLED, coc.nvim includes them
"let g:UltiSnipsListSnippets="<c-l>"
"let g:UltiSnipsExpandTrigger="<cr>"
"let g:UltiSnipsJumpForwardTrigger="<s-tab>"
"let g:UltiSnipsJumpBackwardTrigger="<tab>"
let g:UltiSnipsExpandTrigger = "<NUL>"


" Autocompletion settings - move with tab, confirm with enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <tab>
  \ pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab>
  \ pumvisible() ? "\<c-p>" : "\<s-tab>"

" Open nerdtree
nnoremap <leader>t :NERDTreeToggle<CR>
" Close VIm if NERDTree is the only window visible
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Shortcut for switching on/off pasting mode
function! TogglePaste()
    if(&paste == 0)
        set paste
        echo "Paste Mode Enabled"
    else
        set nopaste
        echo "Paste Mode Disabled"
    endif
endfunction

map <leader>p :call TogglePaste()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"				C/C++
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable debugger
packadd! termdebug
let g:termdebug_useFloatingHover = 1
let g:termdebug_wide=1

if has('nvim')
	tnoremap <Esc> <C-\><C-n>
endif


set mouse=a
if !has('nvim')
	set ttymouse=xterm2
endif

let g:formattters_c = ['clang-format-11']

let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp-cxx-hl.log'
let g:lsp_cxx_hl_verbose_log = 1

" GoTo coc.nvim code navigation.
" Disable Vim's default go to definition
nnoremap <silent> gd <Nop>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Jump between diagnostics
nmap <silent> gp <Plug>(ale_previous)
nmap <silent> gn <Plug>(ale_next)

" Use c-K to show documentation in preview window.
nnoremap <silent>  <c-k> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Expand tabs into spaces
autocmd FileType python setlocal softtabstop=4 expandtab

let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']

let g:formatdef_autopep8 = "'autopep8 - -a -a'"
let g:formatters_python = ['black']

let g:python_highlight_all = 1

let g:pydocstring_doq_path='~/.local/bin/doq'
let pydocstring_formatter='numpy'
let g:python_style='numpy'

" Generate docstring
nmap <silent> <leader>dc <Plug>(pydocstring)

""""""""""" ALE """""""""""
let g:ale_disable_lsp = 1
let g:ale_open_list = 1
let g:ale_completion_autoimport = 1
"let g:ale_linters = {'python':['flake8', 'pylint']}
let g:ale_linters = {'python':['flake8','pylint','pydocstyle'],'cpp':['clang++']}
let g:ale_python_auto_poetry= 1
let g:ale_python_flake8_auto_poetry= 1
let g:ale_python_black_auto_poetry= 1
let g:ale_python_pylint_auto_poetry= 1
let g:ale_python_pydocstyle_auto_poetry= 1

let g:ale_c_build_dir_names = ['.', 'build']

let g:airline#extensions#ale#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"CUSTOM HIGHLIGHTING
" Source:
" https://vi.stackexchange.com/questions/19040/add-keywords-to-a-highlight-group
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
