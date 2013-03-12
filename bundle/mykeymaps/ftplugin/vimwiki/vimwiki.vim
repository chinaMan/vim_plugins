"************************************************************
" FileName: keymaps.vim
" Description: define my keymaps of vim for vimwiki file type
" Author: AndyZeng
" Version: 1.0v
"************************************************************

if exists("s:loaded_keymaps")
    finish
endif
let s:loaded_keymaps = 1

map <F11> :Voom vimwiki<CR>
map <F10> :VoomQuitAll<CR>


