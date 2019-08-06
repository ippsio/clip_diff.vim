if exists('g:loaded_partial_diff')
  finish
endif
let g:loaded_partial_diff = 1

let s:save_cpo = &cpo
set cpo&vim

command! -range PartialDiff :<line1>,<line2>call DoDiffPartially()

function! DoDiffPartially() range
  let s:unnamed_register = @@
  exe a:firstline . "," . a:lastline . "y"
  tabnew
  normal P
  se buftype=nowrite
  diffthis

  " clipboard register to unnamed register
  lefta vnew
  let @@ = *
  normal P
  se buftype=nowrite
  diffthis

  let @@ = s:unnamed_register
endfun

let &cpo = s:save_cpo
unlet s:save_cpo

