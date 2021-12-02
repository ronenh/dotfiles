call plug#begin('~/.vim/plugged')

" Languages
Plug 'fatih/vim-go'
Plug 'python-mode/python-mode'    " Python
Plug 'pangloss/vim-javascript'    " JavaScript
Plug 'leafgarland/typescript-vim' " TypeScript
Plug 'maxmellon/vim-jsx-pretty'   " JSX
Plug 'jparise/vim-graphql'        " GraphQL
Plug 'dag/vim-fish'               " Fish shell

" Plug 'derekwyatt/vim-scala'       " Scala
" Plug 'neovimhaskell/haskell-vim'  " Haskell
" Plug 'lepture/vim-jinja'          " Jinja
" Plug 'hashivim/vim-terraform'     " Terraform


" CoC and plugins
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}


" IDE
Plug 'scrooloose/nerdtree'            " File browser (F3)
Plug 'majutsushi/tagbar'              " Class/module browser (F4)
Plug 'jeetsukumaran/vim-buffergator'  " Buffer manager <leader>bl
Plug 'bling/vim-airline'              " Fancy status line
Plug 'vim-airline/vim-airline-themes' " Pretty status line colors
Plug 'editorconfig/editorconfig-vim'  " Support .editorconfig
Plug 'voldikss/vim-floaterm'
Plug 'luochen1990/rainbow'
" Plug 'idanarye/vim-vebugger'          " Integrate various debuggers

" Color Schemes
"Plug 'altercation/vim-colors-solarized'
"Plug 'cocopon/iceberg.vim'
"Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'


" Editing tools
Plug 'scrooloose/nerdcommenter'   " Code commenter
"Plug 'tpope/vim-surround'         " Quoting/parenthesizing
"Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/yaifa.vim'       " Auto detect indentation
Plug 'godlygeek/tabular'           " Align text
"Plug 'Raimondi/delimitMate'        " Auto close quotes/parentheses
Plug 'jiangmiao/auto-pairs'


" Search
Plug 'mileszs/ack.vim'            " :Ack
Plug 'junegunn/fzf'               " Fuzzy finder
Plug 'junegunn/fzf.vim'           " FZF helpers (:Ag :Rg :Lines etc.)
Plug 'haya14busa/incsearch.vim'   " Incremental search

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" VIM motions on speed
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'


" vim-autoformat
Plug 'Chiel92/vim-autoformat'
call plug#end()

" -------------------------------------------------------------------------------------------------
" Custom settings
" -------------------------------------------------------------------------------------------------

" tabs and spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cinoptions=>s,e0,n0,f1s,{1s,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,J0,)20,*70,#j0
set backspace=indent,eol,start

" show line numbers
set number


" Keep 3 context lines around the viewport
set scrolloff=3

" Enable mouse scrolling and entering visual mode
set mouse=a

" Set to auto read when a file is changed from the outside
set autoread

let mapleader = ","
let g:mapleader = ","

" show hard tabs, trailing whitespace, etc
set listchars=tab:\¬\ ,trail:~,extends:»,precedes:»
set list
nmap <silent> <leader>s :set nolist!<CR>

" Highlight column 120
set colorcolumn=120

" Colors
set background=dark

if has("termguicolors")
  set termguicolors
endif

let g:everforest_background = 'hard'
colorscheme everforest


" Make search case insensitive unless there are capital letters in the search
" expression
set ignorecase
set smartcase

" Moving lines and blocks
nnoremap <silent> [e :m -2<CR>==
nnoremap <silent> ]e :m +1<CR>==
vnoremap <silent> [e :m '<-2<CR>gv=gv
vnoremap <silent> ]e :m '>+1<CR>gv=gv

" always show status bar
set ls=2

" Relative line numbers
set number
set relativenumber

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" Ctrl+n toggles between relative and absolute line numbers
nnoremap <C-n> :call NumberToggle()<cr>

" Switch to absolute line number when vim loses focus
:au FocusLost * :set norelativenumber
:au FocusGained * :set relativenumber

" Switch to absolute line numbers in edit mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber


" Toggle Quickfix and Location lists
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo "Location List is Empty."
    return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

nnoremap <Leader>rm :call delete(@%)

" yank to clipboard by default
set clipboard=unnamed

" more natural split opening
set splitbelow

nmap <silent> <leader>z :bprevious<CR>:bdelete #<CR>

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" -------------------------------------------------------------------------------------------------
"  vim-go
" -------------------------------------------------------------------------------------------------

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1

nmap <silent> <F9> :GoDebugBreakpoint<CR>

" -------------------------------------------------------------------------------------------------
"  Tagbar
" -------------------------------------------------------------------------------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1
"let g:tagbar_left = 1

" -------------------------------------------------------------------------------------------------
"  GitGutter
" -------------------------------------------------------------------------------------------------
highlight! link SignColumn LineNr
let g:gitgutter_set_sign_backgrounds = 1


" -------------------------------------------------------------------------------------------------
" Buffergator
" -------------------------------------------------------------------------------------------------

" Define our own key mapping
let g:buffergator_suppress_keymaps = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" -------------------------------------------------------------------------------------------------
" Python-mode
" -------------------------------------------------------------------------------------------------

" don't use linter, we use ALE for that
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0
let g:pymode_lint_signs = 0
" don't fold python code on open
let g:pymode_folding = 0
" Load rope by default. Change to 0 to disable rope
let g:pymode_rope = 1
let g:pymode_rope_completion = 0  " disable rope completion
" open definitions on same window, and custom mappings for definitions and
" occurrences
let g:pymode_rope_goto_definition_bind = ',d'
let g:pymode_rope_goto_definition_cmd = 'e'
nmap <leader>D :tab split<CR>:PymodePython rope.goto()<CR>
nmap <leader>o :RopeFindOccurrences<CR>
" don't set breakpoints
let g:pymode_breakpoint = 0
let g:pymode_options_max_line_length = 99
" Auto activate virtualenv
let g:pymode_virtualenv = 1

" -------------------------------------------------------------------------------------------------
" NERDTree
" -------------------------------------------------------------------------------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <leader>tf :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" -------------------------------------------------------------------------------------------------
" FZF
" -------------------------------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

nmap <C-p> :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>a :Ag --python

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" -------------------------------------------------------------------------------------------------
" IncSearch
" -------------------------------------------------------------------------------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" -------------------------------------------------------------------------------------------------
" EasyMotion
" -------------------------------------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" Find char (bi-directional)
map  <Leader>f <Plug>(easymotion-bd-f)

" Move to line
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"map <Leader>/ <Plug>(easymotion-sn)
"omap <Leader>/ <Plug>(easymotion-tn)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

" -------------------------------------------------------------------------------------------------
" Airline
" -------------------------------------------------------------------------------------------------

let g:airline_powerline_fonts = 1
"let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
"call airline#parts#define_minwidth('branch', 80)
"call airline#parts#define_minwidth('whitespace', 100)
"call airline#parts#define_minwidth('hunks', 100)
"call airline#parts#define_minwidth('whitespace', 120)
"call airline#parts#define_minwidth('filetype', 140)
"call airline#parts#define_minwidth('ffenc', 140)
"call airline#parts#define_minwidth('tagbar', 180)


" Custom functions
function! ToggleHeader(file)
  if (a:file:e[0] == "c")
    let prefix = "h"
  elseif (a:file:e[0] == "h")
    let prefix = "c"
  else
    return
    :e %<.prefix+a:file:e[1:]
  endfunc

" -------------------------------------------------------------------------------------------------
" FloatTerm
" -------------------------------------------------------------------------------------------------
let g:floaterm_keymap_toggle = '<leader>tt'
let g:floaterm_keymap_new = '<leader>tn'
let g:floaterm_keymap_prev = '<leader>tk'
let g:floaterm_keymap_next = '<leader>tj'

