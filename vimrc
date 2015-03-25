"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
" enoliglesias@gmail.com

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" <-----------Plugins------------>

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'dgsuarez/thermometer'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/neocomplcache'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rake'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" <-----------Configurations------------>

" <--- General --->

syntax enable
set background=dark
colorscheme railscasts

autocmd BufWritePre * :%s/\s\+$//e

"ignore files
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000
set t_Co=256

:imap jj <Esc>

"TAB Autocompletion

let g:neocomplcache_enable_at_startup = 1

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>"
function! s:check_back_space()"{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

"key mapping for tab navigation
nmap <C-Tab> gt
nmap <C-S-Tab> gT

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set number      "add line numbers
set showbreak=...
set wrap linebreak nolist
set laststatus=2
set linespace=4

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

" <--- Airline --->

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='wombat'

" <--- CtrlP --->

set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = '\v.*\/vendor\/.*'
let g:ctrlp_match_window_bottom=0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

let g:path_to_matcher = "~/.vim/bin/matcher/matcher"

if !empty(glob(g:path_to_matcher))
  let g:ctrlp_match_func = { 'match': 'GoodMatch' }
endif

function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")

endfunction

" <--- NERDTree --->

autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" <--- Ack.vim --->

" Ack-grep vim (use this instead ack)
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" <--- Thermometer --->

let g:HgRevInfoTemplate="({branch}:{bookmarks})"

" <--- Syntastic --->

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" <--- Dispatch --->

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" <--- Mappings --->

map <C-n> :NERDTreeToggle<CR>