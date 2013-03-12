if exists('loaded_adjustfont')
	finish
endif
let loaded_adjustfont = 1

nmap <M-,> :SFontSizeInc<cr>
nmap <M-.> :SFontSizeDec<cr>

command! SFontSizeInc call <SID>FontSizeInc()
command! SFontSizeDec call <SID>FontSizeDec()

let g:font_size = 12
function! <SID>FontSizeInc()
	echo 'font size Inc:'
	let g:font_size = g:font_size + 1

	"exec 'set guifont=courier\ New:h'.g:font_size
    exec 'set guifont=Bitstream\ Vera\ Sans\ Mono:h'.g:font_size.'cANSI'
endfunction

function! <SID>FontSizeDec()
    echo 'font size Dec:'
    let g:font_size = g:font_size - 1
    "exec 'set guifont=courier\ New:h'.g:font_size
    exec 'set guifont=Bitstream\ Vera\ Sans\ Mono:h'.g:font_size.'cANSI'
endfunction

