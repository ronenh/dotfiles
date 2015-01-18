set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'klen/python-mode'
Plugin 'scrooloose/syntastic'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'kchmck/vim-coffee-script'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'yaifa.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

 "run pathogen to load all plugins
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()
"call pathogen#infect()

syntax enable
filetype plugin indent on
au BufNewFile,BufRead *.cppml,*.hppml set filetype=cpp

" Set to auto read when a file is changed from the outside
set autoread

" Match more elements using %
runtime macros/matchit.vim

let mapleader = ","
let g:mapleader = ","
set listchars=tab:¬ ,trail:~,extends:»,precedes:«
set invlist

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_loc_list=0
let g:syntastic_loc_list_height=5
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checker_args='--max-line-length=100 --disable=C0103,C0111'
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_coffee_lint_options = "-f ~/.vim/bundle/vim-coffee-script/coffeelint-config.json"


set t_Co=256
set background=dark
colorscheme solarized

"let g:pymode_lint_checker = 'pylint'
"let g:pymode_lint_ignore = 'C0324'
let g:pymode_lint = 0
let g:pymode_lint_signs = 0
let g:pymode_folding = 0
let g:pymode_breakpoint = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_vim_completion = 1
let g:pymode_doc = 0

autocmd FileType python set omnifunc=pythoncomplete#Complete


" show line numbers
set number

" Highlight column 100
set colorcolumn=100

" better buffer management
set hidden

" Make search case insensitive unless there are capital letters in the search
" expression
set ignorecase 
set smartcase

" Keep 3 context lines around the viewport
set scrolloff=3

set laststatus=2
set colorcolumn=100

" Faster viewport scrolling with C-e, C-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.

set tabstop=4
set shiftwidth=4
set expandtab
set cinoptions=>s,e0,n0,f1s,{1s,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,J0,)20,*70,#j0

set listchars=tab:\¬\ ,trail:~,extends:»,precedes:»
set list
nmap <silent> <leader>s :set nolist!<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.cxx
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=[%n]\                      	 " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

nmap <F8> :TagbarToggle<CR>
let g:tagbar_left = 1

" Ctrl-P settings
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|.waf-\w*)$'


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

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction
