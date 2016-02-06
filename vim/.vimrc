set nocompatible
syntax on
filetype plugin on
filetype indent plugin on
" colorscheme darkblue
" colorscheme molokai_k3
colorscheme molokai

set t_Co=256
set hls
set ruler

set number
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set nopaste
set autoindent
set cindent
set incsearch
set hlsearch
set cinoptions=g0

nnoremap<F10> :call ToggleMouseSelect()<CR><Esc>
function! ToggleMouseSelect()
        if(&mouse == "")
                execute ":set mouse=a"
                echo ":set mouse=a"
        else
                execute ":set mouse="
                echo ":set mouse="
        endif
endfunction

" Set folds
set foldcolumn=3
set foldmethod=manual
"set nofoldenable " disable folding

" Set tabs
set showtabline=2

" Set ctags
set tags=$CTAGS_DIR

" Save folds - conflicts with reloading .vimrc when restarting
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

" Tagbar plugin
nmap <F8> :TagbarToggle<CR>

" Make it easy to update/reload vimrc
" <Leader> is mapped to '\' by default, so those commands can
" be invoked by doing \v and \s
"   source $MYVIMRC reloads the saved $MYVIMRC
nmap <Leader>s :source $MYVIMRC<CR>
"   opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nmap <Leader>v :e $MYVIMRC<CR>

" Change autocomplete colors
highlight Pmenu ctermbg=27 ctermfg=black
highlight PmenuSel ctermbg=81 ctermfg=black

" New key mappings for practice
" > Map 'jk' to <Esc> in insert mode
inoremap jk <Esc>
" Normal mode disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" Visual mode disable arrow keys
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
"" Insert mode disable arrow keys
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Set 80 column limit markers
"set textwidth=80
let &colorcolumn=join(range(80,999),",")

" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  endif

" Auto reload vimrc
"augroup reload_vimrc " {
"  autocmd!
"  autocmd BufWritePost $MYVIMRC source $MYVIMRC
"augroup END " }

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
