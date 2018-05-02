set nocompatible
set noshowmode
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
set cursorline
set hlsearch
set autoindent
" Colorscheme
set background=dark
let g:seoul256_background = 236
colo seoul256
hi VertSplit ctermbg=NONE cterm=NONE
set fillchars+=vert:\ 
" Lightline
let g:lightline = { 'colorscheme': 'seoul256' }
let g:lightline.tab_component_function = {
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': '' }
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
command! Hitest so $VIMRUNTIME/syntax/hitest.vim
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
autocmd FileType python setlocal colorcolumn=80,100
" Lightline X CtrlP
function! MyFilename()
  if expand('%:t') == 'ControlP'
    return g:lightline.ctrlp_prev . ' ' . g:lightline.subseparator.left . ' ' . 
          \ g:lightline.ctrlp_item . ' ' . g:lightline.subseparator.left . ' ' .
          \ g:lightline.ctrlp_next
  endif
  if expand('%:t') == '__Tagbar__'
    return  'Tagbar ' . g:lightline.subseparator.left . ' ' . 
          \ g:lightline.fname
  endif
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! CtrlPMark()
  return expand('%:t') =~ 'ControlP' ? g:lightline.ctrlp_marked : ''
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }
function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  let g:lightline.ctrlp_marked = a:marked
  return lightline#statusline(0)
endfunction
function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'
function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

function! MyMode()
  return expand('%:t') == '__Tagbar__' ? 'Tagbar' :
        \ expand('%:t') == 'ControlP' ? 'CtrlP' :
        \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction
