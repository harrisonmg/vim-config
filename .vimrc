set nocompatible
set number
filetype plugin indent on
syntax enable
set wildmenu
set ruler
set ignorecase
set encoding=utf8
set expandtab
set shiftwidth=4
set tabstop=4
hi normal guibg=NONE ctermbg=NONE
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2
colorscheme monokai
set cursorline
set hlsearch
set autoindent
" Insert newlines
nnoremap <c-k> mxo<esc>`x
nnoremap <c-j> mxO<esc>`x
" Set persistent status line
set laststatus=2
" Allow searching of a visual selection with //
vnoremap // y/\V<c-r>"<cr>
" Otherwise // clears the search
nnoremap // :let @/ = ""<cr>
" Allow saving of files as sudo when I forget to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %
" Warn on file change
:au FileChangedShell * echo "Warning: File changed on disk"
" Set default explorer view
let g:netrw_liststyle = 3
" Enable XML highlighting for .launch files
autocmd BufEnter *.launch setlocal syntax=xml
" Setup CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_regexp = 1
" Add helptags
helptags ~/.vim/doc
" Faster tab switching
noremap <c-l> gt
noremap <c-h> gT
" Faster split switching
map <space> <c-w><c-w>
" Enable insert mode arrows
imap <c-h> <Left>
imap <c-j> <Down>
imap <c-k> <Up>
imap <c-l> <Right>
" Fix YAML autospacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" Some fun command maps
command! W w
command! Q q
command! Wq wq
command! WQ wq
command! V tabe ~/.vimrc
command! S source ~/.vimrc
command! WS w | S
command! Ws w | S
command! E Explore
" Enable airline tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#tab_nr_type = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_splits = 0
" Commenting shortcut
if has('win32')
    map <c-/> <plug>NERDCommenterToggle
else
    map <c-_> <plug>NERDCommenterToggle
endif
" Paste yank in insert mode
imap <c-r> <c-r>"
" Yank to EOL, but not CR
noremap Y v$hy
" Show length marker in Python files
autocmd FileType python setlocal colorcolumn=80
