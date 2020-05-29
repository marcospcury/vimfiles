" Disable beep
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
" Based on @mislav post http://mislav.uniqpath.com/2011/12/vim-revisited/
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

execute pathogen#infect()
" My customizations
set ls=2                        " always show status bar
set number                      " show line numbers
set cursorline                  " display a marker on current line
colorscheme molokayo          " set colorscheme

set completeopt=menuone,longest,preview " simple autocomplete for anything
set wildmode=list:longest,full  " autocomplete for paths and files
set wildignore+=.git            " ignore these extensions on autocomplete
set wildignore+=node_modules            " ignore these extensions on autocomplete
set wildignore+=public            " ignore these extensions on autocomplete

set hidden                      " change buffers without warnings even when there are unsaved changes
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'isRuslan/vim-es6'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
call plug#end()

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql Prettier
let g:prettier#config#semi = 'false'

set backupdir=/tmp              " directory used to save backup files
set directory=/tmp              " directory used to save swap files
if has("win32")
  set backupdir=$TEMP
  set directory=$TEMP
endif
set nobackup
set nowritebackup

map <F2> :NERDTreeToggle<CR>
map <F3> :noh<CR>
map <Leader>b :BufOnly<CR>
map zz :w<CR>

let NERDTreeShowHidden=1

:set guioptions+=m  "add menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar

let g:loaded_syntastic_typescript_tsc_checker = 1 "don't do syntax checking

command -nargs=1 C CoffeeCompile | :<args>
nmap <F8> :TagbarToggle<CR>
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '--include-vars',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

map <Leader>n :NERDTreeFind<CR>
imap jj <Esc>
imap { {}<Esc>i
imap ( ()<Esc>i
imap [ []<Esc>i
au GUIEnter * simalt ~x
nmap <F9> :mksession! <cr> " Quick write session with F9
nmap <F10> :source Session.vim <cr> " And load session with F10
set switchbuf+=usetab,newtab
set wrapscan
if has("win32")
  let g:slime_target = "tmux"
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#close_symbol = ''
let g:airline#extensions#tabline#buffer_nr_format = 'b%s: '
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline_theme='dark'

" remap split navigation
let g:NERDTreeIgnore=['\~$', 'node_modules']
let g:NERDTreeIgnore=['\~$', 'public']
let g:NERDTreeIgnore=['\~$', '.git']
let g:NERDTreeIgnore=['\~$', '.cache']
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open splits in a more natural way:
set splitbelow
set splitright

set number relativenumber
set diffopt=filler,vertical
au BufReadPost fugitive:* set bufhidden=delete
fun! QuitPrompt(cmd)
  if tabpagenr("$") == 1 && winnr("$") == 1
    let choice = confirm("Close?", "&yes\n&no", 1)
    if choice == 1 | return a:cmd | endif
    return ""
  else | return a:cmd | endif
endfun
cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? QuitPrompt(getcmdline()) : 'q'
cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == 'wq' ? QuitPrompt(getcmdline()) : 'wq'
cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? QuitPrompt(getcmdline()) : 'x'

" highlight trailing white spaces:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
set completeopt=longest,menuone,preview
" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2
" Enable snippet completion, requires completeopt-=preview
" would need to instal ultisnips, which could conflict with other snippets plugins
"let g:OmniSharp_want_snippet=1


" Easymotion config:
" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-overwin-f2)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
"
