if exists('g:loaded_clip_diff')
  finish
endif
let g:loaded_clip_diff = 1

let s:save_cpo = &cpo
set cpo&vim

command! -range CliplDiff :<line1>,<line2>call ClipDiff()

function! ClipDiff() range
  let s:unnamed_register = @@
  exe a:firstline . "," . a:lastline . "y"
  tabnew
  normal P
  se buftype=nowrite
  diffthis

  lefta vnew
  normal "*P
  se buftype=nowrite
  diffthis

  let @@ = s:unnamed_register
endfun

let &cpo = s:save_cpo
unlet s:save_cpo

