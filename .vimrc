" ========================================================
" File Name : vimrc
" Author : andy zeng
" Time : 2011.3.20
" Version : 1.0
" =======================================================

" *******************************************
"                    General
" *******************************************
set nocompatible   " compatible to vim
set nocp
set history=50     " history cmd of vim
set autoread       " auto read file, when it changed
set nobackup       " close backup
set noswapfile     " don't generate swap file

let g:mapleader=","  " set leader as ,

let &termencoding=&encoding
set fileencodings=utf-8,gb2312,gbk,gb18030
"set termencoding=utf-8
set encoding=prc

set t_Co=256

" *******************************************
" color and Fonts
" ******************************************
" colorscheme   koehler_Ex
" colorscheme  desert
" colorscheme   new
colorscheme   mine
syntax enable
syntax on
"autocmd BufEnter * : syntax syncbind fromstart

" *******************************************
"  Window
" *******************************************
"set scroloff=7
set ruler          " show ruler
set nu             " show line number
set hidden
"command! Bclose call <STD>BufcloseCloseIt()  " not close window, when close buffer
"cau GUIEnter * simalt ~x

" hide menu and toolbar
set guioptions-=m
set guioptions-=T
set guioptions-=t
set guioptions-=b
set guioptions-=l
set guioptions-=L
set guioptions-=R
set guioptions-=r

" *******************************************
"   Font
" *******************************************
"sset guifont=courier\ New:h12
"set guifont= Bitstream\ Vera\ Sans\ Mono:h12
"set guifont= Fixedsys:h12


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
    
    "silent! execute "!dir /s/b *.c, *.cpp, *.h > cscope.files"
    silent! execute "!cscope -Rb -i cscope.files"
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
let Tlist_Ctags_Cmd='ctags'
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
" lookup file
" ***********************************************
let g:LookupFile_DisableDefaultMap=1
let g:LookupFile_TagExpr='"filenametags"'

" ***********************************************
"   vimwiki
" ***********************************************
let g:vimwiki_camel_case=0
let g:vimwiki_use_mouse=0
let g:vimwiki_menu=''
let g:vimwiki_CJK_length=1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
let wiki={}
let wiki.auto_export=1
let wiki.nested_syntaxes={'c': 'c', 'c++': 'cpp', 'python': 'python'}
let wiki.path="~/myCloud//work/wiki/vimwiki"
let wiki.path_html="~/myCloud//work/wiki/vimwiki/html"
let wiki.html_header="~/myCloud/work/wiki/vimwiki/template/header.tpl"
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
let g:showfuncctagsbin = 'ctags.exe'

" ***********************************************
"     vimtweak
" ***********************************************
"command -nargs=1 -bang -complete=command Setalpha :call libcallnr("vimtweak.dll", "SetAlpha", <args>)
"command -nargs=1 -bang -complete=command Settop   :call libcallnr("vimtweak.dll", "EnableTopMost", <args>)
"command -nargs=1 -bang -complete=command Setmax   :call libcallnr("vimtweak.dll", "EnableMaximize", <args>)

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
let g:TagHighlightSettings['CtagsExecutable'] = 'ctags'

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
"   TortoiseSVN
" ************************************************
"let g:tortoiseSvnCmd='TortoiseProc.exe'
"let g:tortoiseSvnInstallAutoCmd=0


"************************************************
"  Grep
"***********************************************"
let Grep_Path='grep'
let Fgrep_Path='fgrep'
let Egrep_Path='egrep'
let Agrep_Path='agrep'
let Grep_Find_Path='find'
let Grep_Xargs_Path='xargs'

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

let g:miniBufExplorerDebugLevel = 10