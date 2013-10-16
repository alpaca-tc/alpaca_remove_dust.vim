"=============================================================================
" FILE: remove_dust
" AUTHOR: Ishii Hiroyuki <alprhcp666@gmail.com>
" Last Modified: 2013-05-30
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
if exists('g:loaded_alpaca_remove_dust')
  finish
endif
let g:loaded_alpaca_remove_dust = 1

let s:save_cpo = &cpo
set cpo&vim

let g:remove_dust_enable = get(g:, 'remove_dust_enable', 0)

function! s:remove_dust() "{{{
  if get(b:, 'remove_dust_enable', g:remove_dust_enable) == 0
    return -1
  endif

  let cursor = getpos('.')

  let space_length = &tabstop > 0 ? &tabstop : 2
  let afford_space  = '                                               '

  %s/\s\+$//ge
  execute '%s/\t/' . afford_space[0:space_length - 1] . '/ge'
  call setpos(".", cursor)
endfunction "}}}

function! s:remove_dust_force()
  RemoveDustEnable
  RemoveDust
endfunction

command! RemoveDustEnable  let b:remove_dust_enable = 1
command! RemoveDustDisable let b:remove_dust_enable = 0
command! RemoveDustForce call <SID>remove_dust_force()
command! RemoveDust call <SID>remove_dust()

augroup RemoveDust
  autocmd!
  autocmd BufWritePre * call <SID>remove_dust()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
