set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Regex search in source code files
Plugin 'mileszs/ack.vim'
" Code and files fuzzy finder
Plugin 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Plugin 'fisadev/vim-ctrlp-cmdpalette'
" Code commenter
Plugin 'scrooloose/nerdcommenter'
" Better file browser
Plugin 'scrooloose/nerdtree'
" Class/module browser
Plugin 'majutsushi/tagbar'
" Airline
Plugin 'bling/vim-airline'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Plugin 'klen/python-mode'
" Python and other languages code checker
Plugin 'scrooloose/syntastic'
" Consoles as buffers
Plugin 'rosenfeld/conque-term'
" Buffer manager
Plugin 'jeetsukumaran/vim-buffergator'
" Compile coffee-script in vim
Plugin 'kchmck/vim-coffee-script'
" Solarized color scheme
Plugin 'altercation/vim-colors-solarized'
" Git integration
Plugin 'tpope/vim-fugitive'
" Show git status in the gutter
Plugin 'airblade/vim-gitgutter'
" Syntax highlighing for .jade files
Plugin 'digitaltoad/vim-jade'
" Syntax highlighing for .styl files
Plugin 'wavded/vim-stylus'
Plugin 'ervandew/supertab'
" Surround
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
" Automatically detect indentation depth, soft-tabs, etc.
Plugin 'yaifa.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


filetype plugin indent on

" tabs and spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set cinoptions=>s,e0,n0,f1s,{1s,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,J0,)20,*70,#j0

" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2

" always show status bar
set ls=2

" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.

" syntax highlight on
syntax on

" use c++ syntax highlighting for cppml files
au BufNewFile,BufRead *.cppml,*.hppml set filetype=cpp

" show line numbers
set number

" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview


set t_Co=256
set background=dark
colorscheme solarized

" Keep 3 context lines around the viewport
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" Set to auto read when a file is changed from the outside
set autoread

" Match more elements using %
runtime macros/matchit.vim

let mapleader = ","
let g:mapleader = ","

" show hard tabs, trailing whitespace, etc
set listchars=tab:\¬\ ,trail:~,extends:»,precedes:»
set invlist
set list
nmap <silent> <leader>s :set nolist!<CR>

" Highlight column 100
set colorcolumn=100

" Make search case insensitive unless there are capital letters in the search
" expression
set ignorecase
set smartcase

" Faster viewport scrolling with C-e, C-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Hide top line buffer list
set hidden
set laststatus=2


" Relative line numbers
"""""""""""""""""""""""
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

" Ctrl+n toggles between relative and absolute line numbers
nnoremap <C-n> :call NumberToggle()<cr>

" Switch to absolute line number when vim loses focus
:au FocusLost * :set number
:au FocusGained * :set relativenumber

" Switch to absolute line numbers in edit mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


" ============================================================================
" Plugins settings and mappings

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1
"let g:tagbar_left = 1

" CtrlP ------------------------------

nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" tags (symbols) in current file finder mapping
nmap <leader>tg :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nmap <leader>tG :CtrlPBufTagAll<CR>
" general code finder in all files mapping
nmap <leader>f :CtrlPLine<CR>
" recent files finder mapping
nmap <leader>m :CtrlPMRUFiles<CR>
" commands finder mapping
nmap <leader>c :CtrlPCmdPalette<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap <leader>wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap <leader>wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap <leader>wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap <leader>we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap <leader>pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap <leader>wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap <leader>wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>

" Show .hidden files
let g:ctrlp_show_hidden = 1
" Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'r'
" ignore these files and folders on file finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|\.build)$',
  \ 'file': '\.pyc$\|\.pyo$|\.log$',
  \ }



" Buffergator ------------------------------

" Define our own key mapping
let g:buffergator_suppress_keymaps = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Syntastic ------------------------------

" show list of errors and warnings on the current file
nmap <leader>e :Errors<CR>
" check also when just opened the file
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✘'
let g:syntastic_warning_symbol='☣'
let g:syntastic_enable_highlighting=1
"let g:syntastic_style_warning_symbol='⚠'
"let g:syntastic_style_enable_highlighting=1
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args='--max-line-length=100 --disable=C0103,C0111'
let g:syntastic_quiet_messages = { "type": "style" }
"let g:syntastic_coffee_lint_options = "-f ~/.vim/bundle/vim-coffee-script/coffeelint-config.json"
let g:syntastic_cpp_checkers = []


" Python-mode ------------------------------

" don't use linter, we use syntastic for that
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
" don't fold python code on open
let g:pymode_folding = 0
" don't load rope by default. Change to 1 to use rope
let g:pymode_rope = 0
" open definitions on same window, and custom mappings for definitions and
" occurrences
let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = 'e'
nmap <leader>D :tab split<CR>:PymodePython rope.goto()<CR>
nmap <leader>o :RopeFindOccurrences<CR>
" don't set breakpoints
let g:pymode_breakpoint = 0

"autocmd FileType python set omnifunc=pythoncomplete#Complete

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <leader>tf :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']



" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#whitespace#enabled = 0
call airline#parts#define_minwidth('filetype', 140)
call airline#parts#define_minwidth('ffenc', 140)
call airline#parts#define_minwidth('tagbar', 250)
