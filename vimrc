"Make sure we are using pathogen
execute pathogen#infect()

" Use Vim settings, rather than Vi settings
" Setup right after pathogen due to side effects
set nocompatible

" ========================= General Config ===================================

set number
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

" Show me tabs, trailing spaces
set list listchars=tab:→\ ,trail:·,extends:>

" Do not use this anymore - but still keeping it here
" set mouse=a

" Turn on syntax highlighting
syntax on

au BufLeave,FocusLost * silent! wall

" =========================== Indentation ===================================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
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
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=*.eot,*.svg,*.ttf,*.woff,*.jpg,*.png,*.gif,*.swp,*.psd

" =========================== Custom Colors ==================================

hi CursorLine gui=underline cterm=underline ctermbg=none ctermfg=none
hi SpecialKey ctermbg=red guibg=red ctermfg=white

hi UnwantedTab guibg=red ctermbg=red
hi TrailSpace guibg=red ctermbg=red

match UnwantedTab /\t/
match TrailSpace / \+$/

hi Folded ctermbg=none ctermfg=yellow cterm=bold

hi Search ctermfg=black cterm=bold
hi IncSearch ctermfg=black ctermbg=yellow cterm=bold

hi SpellBad ctermfg=gray ctermbg=darkred cterm=underline,bold


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
nmap <C-Up> <C-w><Up>
nmap <C-Left> <C-w><Left>
nmap <C-Right> <C-w><Right>
nmap <C-Down> <C-w><Down>

"Keeping this here because this matches the <F8> and  <F7> settings
au InsertEnter * :set number
au InsertLeave * :set relativenumber

"Other keys mapped - for plugins
"<F9> and <F12>

" ========================== Plugin Settings ================================

"Begin powerline/airline

set laststatus=2
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set t_Co=256
set encoding=utf-8
set statusline=%{fugitive#statusline()}

if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

let g:airline_powerline_fonts=1

"End powerline

"Begin syntastic

let g:syntastic_less_checkers=['lessc']
let g:syntastic_html_checkers=[]
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_jshint_conf="~/.vim/.jshintrc"

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
