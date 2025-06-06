if exists('g:loaded_clip_diff')
  finish
endif
let g:loaded_clip_diff = 1

let s:save_cpo = &cpo
set cpo&vim

command! -range CliplDiff :<line1>,<line2>call ClipDiff()

function! ClipDiff() range
  exe a:firstline . "," . a:lastline . "y"

  tabnew _SELECTED_
  normal P
  se buftype=nowrite
  set filetype=clip_diff
  diffthis

  rightb vnew _CLIPBORD_
  normal "+P
  se buftype=nowrite
  set filetype=clip_diff
  diffthis
endfun

function! s:CloseTabIfLastClipDiffWindow()
  " タブ内のバッファを全て閉じる
  for b in tabpagebuflist(tabpagenr())
    if bufexists(b) && getbufvar(b, '&filetype') ==# 'clip_diff'
      execute 'bdelete!' b
    endif
  endfor
endfunction
autocmd WinClosed * if &filetype ==# 'clip_diff' | call <SID>CloseTabIfLastClipDiffWindow() | endif

let &cpo = s:save_cpo
unlet s:save_cpo
