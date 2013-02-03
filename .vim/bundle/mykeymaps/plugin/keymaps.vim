"************************************************************
" FileName: keymaps.vim
" Description: define my keymaps of vim
" Author: AndyZeng
" Version: 1.0v
"************************************************************

if exists("s:loaded_Mykeymaps")
    finish
endif
let s:loaded_Mykeymaps = 1

" ===========base move in file==========
"          k
"      h      l
"          j
" 

" pageup and page down
map  mm  <C-d>
map  mn  <C-u>
map  mf  <C-f>
map  mb  <C-b>

" move in window
map  <leader>wh  <C-w>h
map  <leader>wj  <C-w>j
map  <leader>wl  <C-w>l
map  <leader>wk  <C-w>k


" move in buffer
map gj   :bp<cr>
map gk   :bn<cr>

" copy & paste
map <C-c>  "*y
map <C-p>  "*p

" adjust window size
map <C-Up> <C-w>+
map <C-Down> <C-w>-
map <C-Left> <C-w><
map <C-Right> <C-w>>

" use <SPACE> as :
nmap ' :
nmap <SPACE> <C-d>


"===========plugin map================"
" taglist
map <leader>tag :TlistToggle<cr>

"cscope
map <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
map <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
map <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
map <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
map <leader>f :cs find f <C-R>=expand("<cword>")<CR><CR>
map <leader>i :cs find i <C-R>=expand("<cword>")<CR><CR>

map <M-Left>  :cp<CR>
map <M-Right> :cn<CR>
map csl :cn<cr>
map csh :cp<cr>

" NERDTree
map <leader>fb :NERDTreeToggle<CR>

"conque
command -nargs=0 -bang -complete=command Cmd :ConqueTermSplit cmd
command -nargs=0 -bang -complete=command Cmdtab :ConqueTermTab cmd
command -nargs=0 -bang -complete=command Bash :ConqueTerm bash 
command -nargs=0 -bang -complete=command Bashtab :ConqueTermTab bash 

" fufinder
map <leader>fs :FufFile<CR>
map <leader>bf :FufBuffer<CR>
map <leader>tf :FufTag<CR>
map <leader>df :FufDir<CR>

" preview
command -narg=0 -bang -complete=command Preswitch :call g:OW_EnablePreviewWindow()




