set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

" Languages
Plug 'python-mode/python-mode'    " Python
Plug 'fatih/vim-go'               " Go
Plug 'derekwyatt/vim-scala'       " Scala
Plug 'pangloss/vim-javascript'    " JavaScript
Plug 'leafgarland/typescript-vim' " TypeScript
Plug 'maxmellon/vim-jsx-pretty'   " JSX
Plug 'jparise/vim-graphql'        " GraphQL
Plug 'neovimhaskell/haskell-vim'  " Haskell
Plug 'lepture/vim-jinja'          " Jinja
Plug 'hashivim/vim-terraform'     " Terraform
Plug 'dag/vim-fish'               " Fish shell

" Linters and fixers
Plug 'dense-analysis/ale'
let g:ale_disable_lsp = 1  " Use CoC for all LSP features

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-pyright', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}

" IDE
Plug 'scrooloose/nerdtree'            " File browser (F3)
Plug 'majutsushi/tagbar'              " Class/module browser (F4)
Plug 'jeetsukumaran/vim-buffergator'  " Buffer manager <leader>bl
Plug 'bling/vim-airline'              " Fancy status line
Plug 'vim-airline/vim-airline-themes' " Pretty status line colors
Plug 'altercation/vim-colors-solarized'
Plug 'editorconfig/editorconfig-vim'  " Support .editorconfig
Plug 'idanarye/vim-vebugger'          " Integrate various debuggers

" Editing tools
Plug 'scrooloose/nerdcommenter'   " Code commenter
"Plug 'tpope/vim-surround'         " Quoting/parenthesizing
"Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/yaifa.vim'       " Auto detect indentation
Plug 'godlygeek/tabular'           " Align text
Plug 'Raimondi/delimitMate'        " Auto close quotes/parentheses

" Search
Plug 'mileszs/ack.vim'            " :Ack
Plug 'junegunn/fzf'               " Fuzzy finder
Plug 'junegunn/fzf.vim'           " FZF helpers (:Ag :Rg :Lines etc.)
Plug 'haya14busa/incsearch.vim'   " Incremental search

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Auto completion
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }     " LSP auto completion engine
"Plug 'ervandew/supertab'
" Autocompletion on steroids
"Plug 'Shougo/neocomplete'
"Plug 'davidhalter/jedi-vim'

" VIM motions on speed
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'

" Snippets
"Plug 'sirver/ultisnips'
"Plug 'honza/vim-snippets'

" vim-autoformat
Plug 'Chiel92/vim-autoformat'

call plug#end()
" End plugin setup


" tabs and spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cinoptions=>s,e0,n0,f1s,{1s,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,J0,)20,*70,#j0
set backspace=indent,eol,start

" Force .md files to be interpreted as markdown instead of Modula-2
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

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

set background=dark
colorscheme solarized

" Keep 3 context lines around the viewport
set scrolloff=3

" Enable mouse scrolling and entering visual mode
set mouse=a

" Auto completion of VIM commands
set wildmenu
set wildmode=full

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
if has('nvim')
  set viminfo+=n~/.vim/dirs/nviminfo
else
  set viminfo+=n~/.vim/dirs/viminfo
endif
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
set list
nmap <silent> <leader>s :set nolist!<CR>

" Highlight column 120
set colorcolumn=120

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

" Moving lines and blocks
nnoremap <silent> [e :m -2<CR>==
nnoremap <silent> ]e :m +1<CR>==
vnoremap <silent> [e :m '<-2<CR>gv=gv
vnoremap <silent> ]e :m '>+1<CR>gv=gv

" CoC stuff
"""""""""""""""""""""""""""""""
" More room for error messages
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the sign column
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" Relative line numbers
"""""""""""""""""""""""
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
set splitright


" ============================================================================
" Plugins settings and mappings

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1
"let g:tagbar_left = 1

" GitGutter
highlight! link SignColumn LineNr
let g:gitgutter_set_sign_backgrounds = 1


" Buffergator ------------------------------

" Define our own key mapping
let g:buffergator_suppress_keymaps = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" ------------------------------------------
" ALE (async lint engine) ------------------
" ------------------------------------------
"  Error/Warning signs
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '≫'
highlight! link ALEErrorSign GitGutterDelete
highlight! link ALEWarningSign GitGutterChange

let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" Python-mode ------------------------------

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

" vim-go
nmap <silent> <F9> :GoDebugBreakpoint<CR>
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1


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


" IncSearch ------------------------
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)


" EasyMotion ------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap <Leader>s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
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


" FZF ------------------------------
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

" Auto Format
noremap <F5> :Autoformat<CR>
let g:formatdef_scalafmt = "'scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']

" UltiSnips
let g:UltiSnipsListSnippets="<c-l>"

" Terraform
let g:hcl_align = 1

highlight! link goCustomFuncDef Function
highlight! link goCustomFunc Function
