"----------------------------Setup for vim -------------------------------
set nocompatible              
filetype off                 
set rtp+=~/.vim/plugged
"---------------------------Vim Plug------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-sort-motion'
Plug 'danro/rename.vim'
Plug 'kien/ctrlp.vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'ruanyl/vim-fixmyjs'
Plug 'scrooloose/nerdtree'
Plug 'ternjs/tern_for_vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/indentLine'

call plug#end()

"----------------------------------Airline for vim----------------------
set laststatus=2
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
"-----------------------------------Basic Indenting------------------------
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
let delimitMate_expand_cr=1
let g:indentLine_char = '|'

"------------------------------------Theme---------------------------------
syntax enable
let base16colorspace=256 
colorscheme base16-default-dark
"-----------------------------------Basic Settings------------------------

let g:NERDTreeHijackNetrw=0
filetype plugin indent on
set number
set relativenumber
set path+=*
"--------------------------------KeyMappings--------------------------------
:inoremap jj <esc>
let mapleader = ","
map <C-l> mzgg=G`z
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
map ; :
map <C-b> :NERDTreeToggle<CR>

"----------------------------------Linting----------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

"-----------------------------vim-multipl-cursors--------------------------------
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-h>'

"----------------------------controlp------------------------------------
set wildignore+=**/bower_components/*,**/node_modules/*,**/tmp/*,**/assets/images/*,**/assets/fonts/*,**/public/images/*
"--------------------------------ternjs---------------------------------
autocmd CompleteDone * pclose

"---------------------------------disable swapfile-------------------------
set noswapfile

"---------------------------------------Ulti snips---------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetsDir        = $HOME.'/.vim/plugged/UltiSnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

"-------------------------------------Create/open file in curren folder
map <Leader>ee :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>

"--------------------------Create folders on file save
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
        \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
        \ endif
augroup END

"-------------------Custom Script---------------------
" CtrlP auto cache clearing.
" ----------------------------------------------------------------------------
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction

if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
endif

"-----------------------------------Syntax--------------------------------------
let g:jsx_ext_required = 0
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js"

"-----------------------------------Fixmyjs----------------------------
let g:fixmyjs_engine = 'eslint'
noremap <c-m> :Fixmyjs<CR>

" Remove whitespaces on save saving cursor position
" =================================================

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
