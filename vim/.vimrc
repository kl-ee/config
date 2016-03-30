set nocompatible
filetype plugin on
" colorscheme darkblue
" colorscheme molokai_k3
"colorscheme molokai
colorscheme wombat256mod_pi

" Setup Pathogen
" https://github.com/tpope/vim-pathogen
syntax on
filetype plugin indent on
execute pathogen#infect()

" Setup rainbow parentheses plugin
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Eager load fireplace session
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" Custom settings
set t_Co=256
set hls
set ruler

set wildmenu                    " display command auto complete options
set wildmode=longest:list,full  " diplay matching list (similar to ls) on first <Tab> then open the wildmenu on the second <Tab>(t
                                "    - used with ':' commands (i.e. :vs, :sp, :e) followed by a <Tab>
set nowrap                      " do not wrap lines to start with
set hls                         " set no highlight search (turn off by using set hls/turn on with nohls)
set incsearch                   " set so we search as we type
set ruler                       " ensures each window contains a statusline that displays current cursor position
set nobackup                    " do not keep a backup file
set number                      " display line numbers
set tabstop=8                   " number of spaces that a <Tab> in a file counts for
set shiftwidth=4                " number of spaces to use for each step of indentation
set softtabstop=4               " number of spaces that a <Tab> keypress counts for
set expandtab                   " insert spaces in place of *all* <Tab> keypresses
set makeprg=make                " go back to using make (instead of pmake)
set cino=t0,g2,c0,C1            " do not indent function return types, indent public/protected/private by 2,
                                " do not indent after opening comment(/*), do not indent text after opening comment(/*)
                                "    (see: http://vimdoc.sourceforge.net/htmldoc/indent.html)

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

" Change autocomplete colors
highlight Pmenu ctermbg=27 ctermfg=black
highlight PmenuSel ctermbg=81 ctermfg=black
" autocmd VimEnter * hi Pmenu ctermbg=black
" autocmd VimEnter * hi PmenuSel ctermbg=lightblue


" New key mappings for practice
" > Map 'jk' to <Esc> in insert mode
inoremap jk <Esc>
" Normal mode disable arrow keys
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"" Visual mode disable arrow keys
"vnoremap <up> <nop>
"vnoremap <down> <nop>
"vnoremap <left> <nop>
"vnoremap <right> <nop>
"" Insert mode disable arrow keys
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>


" Disable man page hotkey
nnoremap K <nop>

" Set 80 column limit markers
"set textwidth=80
let &colorcolumn=join(range(80,80),",")

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
