XPTemplate priority=lang

let s:f = g:XPTfuncs()

fun! s:f._xGetCurrentDate()
    let date = strftime("%Y/%m/%d") 
    return date
endfunction

XPT signline
//AndyZeng `cusor^, `$_xGetCurrentDate ,for `comment^

XPT signblock
//AndyZeng `cusor^, `$_xGetCurrentDate ,for `comment^, begin {
//}AndyZeng `cusor^, `$_xGetCurrentDate ,for `comment^, end
