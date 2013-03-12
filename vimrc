" ========================================================
" File Name : vimrc
" Author : andy zeng
" Time : 2011.3.20
" Version : 1.0
" =======================================================

" *******************************************
"                    General
" *******************************************
set nocompatible   " not compatible to vi
set history=50     " history cmd of vim
set autoread       " auto read file, when it changed
set nobackup       " close backup
set noswapfile     " don't generate swap file

let g:mapleader=","  " set leader as ,


" *******************************************
"  encoding
" ******************************************
let &termencoding=&encoding
set fileencodings=utf-8,gb2312,gbk,gb18030
set encoding=prc

if has("gui")
else
set t_Co=256
endif

" *******************************************
" color scheme and Fonts
" ******************************************
if has("gui")      " color scheme
    colorscheme koehler_ex
else
    colorscheme mine
endif
if has("win32")    " font
    set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
endif

syntax enable
syntax on
"autocmd BufEnter * : syntax syncbind fromstart

" *******************************************
"  Window
" *******************************************
set ruler          " show ruler
set nu             " show line number
set hidden

"command! Bclose call <STD>BufcloseCloseIt()  " not close window, when close buffer

" maximure gvim in window
if has("win32")
    au GUIEnter * simalt ~x
endif

" hide menu and toolbar in gvim
if has("gui")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=t
    set guioptions-=b
    set guioptions-=l
    set guioptions-=L
    set guioptions-=R
    set guioptions-=r
endif

" go default path in window
if has("win32")
    cd E:\
endif

" *******************************************
"   pathogen
" *******************************************
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles() 

" *******************************************
"  indent
" *******************************************
filetype plugin on
filetype indent on
set autoindent
set cindent
set smartindent

" *******************************************
"  tab setting
" *******************************************
set tabstop=4
set shiftwidth=4 
set expandtab
autocmd FileType c,cpp set textwidth=100 | set list listchars=tab:>-

" *******************************************
"   folding
" *******************************************
set foldmethod=syntax

" *******************************************
"   search
" *******************************************
set ignorecase
set incsearch
set hlsearch
set showmatch

" *******************************************
"  tags
" *******************************************
if !exists("tags")
    set tags=./tags
endif

" update tags file
function! Update_Tags()
    "if has("ctags")
        silent! execute "!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q ."
    "endif
    set tags=tags
endfunction

" *******************************************
"   cscope
" *******************************************
" update cscope.out
function! Update_Cscope()
    silent! execute "cs kill -1"        
    if has("win32")    
        silent! execute "!dir /s/b *.c, *.cpp, *.h > cscope.files"
        silent! execute "!cscope -Rb -i cscope.files"
    else
        silent! execute "!cscope -Rbq"
    endif
    execute "normal :"

    if filereadable("cscope.out")
        execute "cs add cscope.out"
    endif
endfunction

function! Update_Database()
    : call Update_Tags()
    : call Update_Cscope()
    : UpdateTypesFileOnly
endfunction

function! Add_CtagsCscFile()
	set tags=tags
	execute "cs add cscope.out"
endfunction

" update tag and cscope
map <F6> :call Update_Database()<CR>

" add ctagscscope
map <leader>a :call Add_CtagsCscFile()<CR>

" *********************************************
" taglist
" *********************************************
if has("win32")
let Tlist_Ctags_Cmd='ctags.exe'
else
let Tlist_Ctags_Cmd='ctags'
endif
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
""let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_Menu=1
"let Tlist_Auto_Open=1
let Tlist_WinWidth=45
"let Tlist_Use_Right_Window=1
let tlist_c_settings='c;c:class;d:marco;e:enum;f:function;s:structure;t:typedef;u:union;v:variable'

" *********************************************
" cscope setup
" *********************************************
function! SearchS()
    "":cs find s <C-R>=expand("<cword>")<CR><CR>
    let s:word = expand("<cword>")
    echo s:word
    exec "cs find s " . s:word . " \<CR>"
    :pc!
    :cw
endfunction    
set cscopequickfix=s-,c-,d-,i-,t-,e-

" **********************************************
" NERDTree 
" **********************************************
let NERDTreeWinPos='right'

" ***********************************************
"   vimwiki
" ***********************************************
let wiki={}
if has("win32")
    let s:vimwikipath = "E:\\wiki\\vimwiki"
    let wiki.path = s:vimwikipath
    let wiki.path_html=s:vimwikipath."\\html"
    let wiki.html_header=s:vimwikipath."\\template\\header.tpl"
else
    let s:vimwikipath = "~/myCloud/work/wiki/vimwiki"
    let wiki.path = s:vimwikipath
    let wiki.path_html=s:vimwikipath."/html"
    let wiki.html_header=s:vimwikipath."/template/header.tpl"
endif
let wiki.auto_export=1
let wiki.nested_syntaxes={'c': 'c', 'c++': 'cpp', 'python': 'python'}
let g:vimwiki_camel_case=0
let g:vimwiki_use_mouse=0
let g:vimwiki_menu=''
let g:vimwiki_CJK_length=1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
let g:vimwiki_list=[wiki]

" ***********************************************
"   completeopt
" ***********************************************
set completeopt=menu

" ***********************************************
"   omniCppcomplete
" ***********************************************
let OmniCpp_GlobalScopeSearch = 1  " 0 or 1
let OmniCpp_NamespaceSearch = 1   " 0 ,  1 or 2
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1

" ***********************************************
"   show func
" ***********************************************
map <leader>sh  : <Plug>ShowFunc
if has("win32")
    let g:showfuncctagsbin = 'ctags.exe'
else
    let g:showfuncctagsbin = 'ctags'
endif

" ***********************************************
"     vimtweak (only winow)
" ***********************************************
if has("win32")
    command -nargs=1 -bang -complete=command Setalpha :call libcallnr("vimtweak.dll", "SetAlpha", <args>)
    command -nargs=1 -bang -complete=command Settop   :call libcallnr("vimtweak.dll", "EnableTopMost", <args>)
    command -nargs=1 -bang -complete=command Setmax   :call libcallnr("vimtweak.dll", "EnableMaximize", <args>)
endif

" ***********************************************
"    preview window
" ***********************************************
set ut=1500
set previewheight=6

" ***********************************************
"   ctags hightlight
" ***********************************************
if ! exists('g:TagHighlightSettings')
    let g:TagHighlightSettings = {}
endif
let g:TagHighlightSettings['ForcedPythonVariant'] = 'if_pyth'
if has("win32")
    let g:TagHighlightSettings['CtagsExecutable'] = 'ctags.exe'
else
    let g:TagHighlightSettings['CtagsExecutable'] = 'ctags'
endif

hi CTagsNormal guifg=lightblue 

hi def link CTagsFunction    FunctionType
hi def link CTagsType Type
hi def link CTagsStructure Type
hi def link CTagsDefinedName  Type
hi def link CTagsGlobalVariable GlobalVariable
hi def link CTagsLocalVariable  LocalVariable
hi def link CTagsMember LocalVariable
hi def link CTagsConstant  Constant
hi def link CTagsEnumeratorName Type
hi def link CTagsEnumerationValue Constant

" ***********************************************
"   Fuf
" ***********************************************
function! FufFiles(cmd)
    silent exec "normal ,tag"    
    if a:cmd == "File"
        :FufFile()
    else if a:cmd == "Buffer"
        :FufBuffer()
    endif
endfunction
""map <leader>fs :call FufFiles("File")<CR>
""map <leader>fs :call FufFiles("Buffer")<CR>

" ************************************************
"   Show Mark
" ************************************************
let g:showmarks_include = "abcdefghijklopqrstuvwxyzABCDEFGHIJKLOPQRSTUVWXYZ"
let g:showmarks_ignore_type="hpr"
let g:showmarks_auto_enable=0

" ************************************************
"   XPT
" ************************************************
let g:xptemplate_vars = 'author=AndyZeng&email=andy_zeng@mdv.com.tw'

" ************************************************
"   TortoiseSVN (only window)
" ************************************************
if has("win32")
    let g:tortoiseSvnCmd='TortoiseProc.exe'
    let g:tortoiseSvnInstallAutoCmd=0
endif


"************************************************
"  Grep
"***********************************************"
if has("win32")
let Grep_Path='d:\GetGnuWin32\bin\grep.exe'
let Fgrep_Path='d:\GetGnuWin32\bin\fgrep.exe'
let Egrep_Path='d:\GetGnuWin32\bin\egrep.exe'
let Agrep_Path='d:\GetGnuWin32\bin\agrep.exe'
let Grep_Find_Path='d:\GetGnuWin32\bin\find.exe'
let Grep_Xargs_Path='d:\GetGnuWin32\bin\xargs.exe'
else
let Grep_Path='grep'
let Fgrep_Path='fgrep'
let Egrep_Path='egrep'
let Agrep_Path='agrep'
let Grep_Find_Path='find'
let Grep_Xargs_Path='xargs'
endif

"************************************************
"  indent-guide
"***********************************************"
let g:indent_guides_guide_size=1

"************************************************
"  voom
"***********************************************"
set fmr=<<<,>>>
syn match zkey "<<<d" contained
syn match zhead0 "^.+<<<d" contains=zkey 
syn match zhead1 "^.+<<<1" contains=zkey
syn match zhead2 "^.+<<<2" contains=zkey 
syn match zhead3 "^.+<<<3" contains=zkey
syn match zhead4 "^.+<<<4" contains=zkey
hi link zkey ignore

"***********************************************
"  vimmailr
"**********************************************"
let $MYEMAIL="AndyZeng@mdv.com.tw"

"***********************************************
"  power line
"**********************************************"
set guifont=PowerlineSymbols\ for\ Powerline
let g:Powerline_symbols='fancy'
let g:Powerline_dividers_override = ['>>', '>', '<<', '<']
let g:Powerline_cache_enabled = 0

