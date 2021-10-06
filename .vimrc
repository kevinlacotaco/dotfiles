"Make sure we are using pathogen
execute pathogen#infect()

" Add fzf to the runtime path
set rtp+=~/.fzf

" Use Vim settings, rather than Vi settings
" Setup right after pathogen due to side effects
set nocompatible

" ======================== Color Scheme Def ==================================

set t_Co=256
let g:solarized_termcolors=256
let g:solarized_degrade=1
let g:solarized_termtrans=1
set background=dark
colorscheme solarized

" ========================= General Config ===================================

set relativenumber
set ruler

set backspace=indent,eol,start     " Backspace my way through insert mode
set whichwrap=bs<>[]               " Backspace wraps
set showcmd                        " Show incomplete commands

set hidden                         " Hide buffers instead of closing them

set autoread                       " Reload files changed outside of Vim

set spell                          " Turn on spell check

set showmatch                      " Show matching brace

set cursorline

set title
if v:servername == ''
    set titlestring=%t%(\%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)\ \-\ VIM
else
    set titlestring=%t%(\%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)\ \-\ %{v:servername}
endif

" Show me tabs, trailing spaces
set list listchars=tab:→\ ,trail:·,extends:>

set mouse=n

set fillchars+=stl:\ ,stlnc:\ "

set clipboard=unnamed

" Turn on syntax highlighting
syntax on

au BufLeave,FocusLost * silent! wall

set foldmethod=indent
set foldlevelstart=10

set textwidth=125
set colorcolumn=+1

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,n~/.viminfo
set undofile
set undodir=/Users/kevin/.vim/undodir

" =========================== Indentation ===================================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set expandtab

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " ...
endif

" ============================ Searching ====================================

set incsearch
set ignorecase
set smartcase
set hlsearch


" ============================ Completion ===================================

set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/war/*,*.orig
set wildignore+=*.eot,*.svg,*.ttf,*.woff,*.jpg,*.png,*.gif,*.swp,*.psd,*node_modules/*

" =========================== Custom Colors ==================================

" hi CursorLine gui=underline cterm=underline ctermbg=none ctermfg=none
hi CursorLine gui=none cterm=none ctermbg=235 ctermfg=none
hi SpecialKey ctermbg=red guibg=red ctermfg=white

hi UnwantedTab guibg=red ctermbg=red
hi TrailSpace guibg=red ctermbg=red

match UnwantedTab /\t/
match TrailSpace / \+$/

hi Folded ctermbg=none ctermfg=yellow cterm=bold
" highlight Folded ctermbg=darkgray ctermfg=yellow cterm=bold

hi Search ctermfg=black cterm=bold
hi IncSearch ctermfg=black ctermbg=yellow cterm=bold
" hi Search ctermbg=lightgray ctermfg=darkblue
" hi IncSearch ctermbg=none ctermfg=darkyellow

hi SpellBad ctermfg=gray ctermbg=darkred cterm=underline,bold

hi Todo ctermbg=none ctermfg=yellow cterm=bold gui=bold
" hi String ctermfg=darkgreen

" ============================ File Types ====================================

au BufRead,BufNewFile *.less set filetype=less.css
au BufRead,BufNewFile *.json set filetype=javascrtipt

" ============================= Mappings =====================================

"Map F2 to save modified file
nmap <F2> :update<CR>
vmap <F2> <Esc><F2>gv
imap <F2> <c-o><F2>

"Map F3 to no highlighting
nmap <F3> :nohl<CR>
vmap <F3> <Esc><F3>gv
imap <F3> <c-o><F3>

"Map F7 and F8 to toggle line numbers and relative line numbers respectively
nmap <F7> :set invnumber<CR>
vmap <F7> <Esc><F7>gv
imap <F7> <c-o><F7>

function! ToggleRelativeNumber()
    if(&relativenumber == 1)
        set invnumber
        set nonumber
    else
        set relativenumber
    endif
endfunction

nmap <F8> :call ToggleRelativeNumber()<CR>
vmap <F8> <Esc><F8>gv
imap <F8> <c-o><F8>

"Map Ctrl-Arrow to Window switching
"nmap <C-Up> <C-w><Up>
"nmap <C-Left> <C-w><Left>
"nmap <C-Right> <C-w><Right>
"nmap <C-Down> <C-w><Down>

map <c-h> <C-w>h
map <c-k> <C-w>k
map <c-j> <C-w>j
map <c-l> <C-w>l

map <DOWN> gj
map <UP> gk

"Keeping this here because this matches the <F8> and  <F7> settings
au InsertEnter * :set number
au InsertLeave * :set relativenumber

"Find files under cursor
nnoremap gf <c-v>iwgf
set path+=~/Repositories/**
set suffixesadd=.js,.less,.html,.json,.htm
set suffixes=.class

"Other keys mapped - for plugins
"<F9> and <F12>

" ============================ Auto Group ==================================

augroup LargeFile
        let g:large_file = 1048576 " 10MB

        " Set options:
        "   eventignore+=FileType (no syntax highlighting etc
        "   assumes FileType always on)
        "   noswapfile (save copy of file)
        "   bufhidden=unload (save memory when other file is viewed)
        "   buftype=nowritefile (is read-only)
        "   undolevels=-1 (no undo possible)
        au BufReadPre *
                \ let f=expand("<afile>") |
                \ if getfsize(f) > g:large_file |
                        \ set eventignore+=FileType |
                        \ set syntax=off |
                        \ setlocal noswapfile bufhidden=unload undolevels=-1 |
                \ else |
                        \ set eventignore-=FileType |
                \ endif
augroup END

" Ignore CamelCase words when spell checking
fun! IgnoreCamelCaseSpell()
  syn match CamelCase /[a-zA-Z]\w\+[A-Z]\w\+/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()

autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.ts :%s/\s\+$//e

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal! g'\"" | endif
"endif

" Taken shamelessly from http://stackoverflow.com/questions/2393671/vim-restores-cursor-position-exclude-special-files
let g:noRestorePositionList = [ 'COMMIT_EDITMSG' ]

function! GoToLastEditedPosition()
  if ( index( g:noRestorePositionList, expand( "%:t" ) ) >= 0 )
    return
  endif

  let lastLine = line( "'\"" )

  if ( lastLine > 0 && lastLine <= line( '$' ) )
    normal! g`"
  endif
endfunction

if has("autocmd")
    au BufReadPost * call GoToLastEditedPosition()
endif
" ========================== Plugin Settings ================================

"Begin powerline/airline/lightline

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ], ['ctrlpmark'] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'separator': { 'left': '', 'right': ''},
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⎇  '.branch : ''
  endif
  return ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction
"End powerline

"Begin syntastic

let g:syntastic_less_checkers=['css/stylelint']
let g:syntastic_scss_checkers=['css/stylelint']
let g:syntastic_css_checkers=['css/stylelint']
let g:syntastic_yaml_checkers = ['yaml/yamllint']
let g:syntastic_html_checkers=[]
let g:syntastic_javascript_checkers=['javascript/eslint']
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_eslint_exe = '$([ -f $(npm bin)/eslint ] && which $(npm bin)/eslint || which eslint)'
let g:syntastic_error_symbol='✗'

hi SyntasticError ctermbg=red ctermfg=black
hi SyntasticWarning ctermbg=yellow ctermfg=black
"End syntastic

"Start tagbar

nmap <F9> :TagbarToggle<CR>
nmap <F12> :TagbarOpen fj<CR>

let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/usr/local/bin/jsctags'
    \ }

"End tagbar

"Start SuperTab

let g:SuperTabNoCompleteAfter=[ '^', '\s', '*', '//' ]

"End SuperTab

"Begin Fzf

let $FZF_DEFAULT_COMMAND ='ag -l -S -U --nocolor --nogroup --hidden
            \ --ignore .git
            \ --ignore .svn
            \ --ignore .hg
            \ --ignore .DS_Store
            \ --ignore "node_modules"
            \ -g ""'
"End Fzf

"Begin Ctrlp

let g:ctrlp_by_filename = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_user_command = 'ag -l -S --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "node_modules"
      \ -g "" %s'
"let g:ctrlp_lazy_update = 25

nnoremap <c-p> :Files<CR>
"End Ctrlp

"Begin Local VimRc

let g:localvimrc_ask = 0
"End Local VimRc
