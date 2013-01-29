if exists('g:loaded_alpaca_remove_dust') && g:loaded_alpaca_remove_dust
    finish
endif
let g:loaded_alpaca_remove_dust = 1

if !exists('g:remove_dust_enable')
  let g:remove_dust_enable=1
endif

" 保存時に無駄な文字を消す {{{
function! s:remove_dust()
  if !exists('b:remove_dust_enable')
    return
  endif

  if b:remove_dust_enable == 0|return|endif

  let cursor = getpos(".")
  let space_length = &ts > 0? &ts : 2
  let space  = ""
  while space_length > 0
    let space .= " "
    let space_length -= 1
  endwhile

  %s/\s\+$//ge
  exec "%s/\t/".space."/ge"
  call setpos(".", cursor)
  unlet cursor
endfunction "}}}

command! RemoveDustEnable  let b:remove_dust_enable=1
command! RemoveDustDisable let b:remove_dust_enable=0
command! RemoveDustRun call <SID>remove_dust()

augroup RemoveDust
  au!
  au BufWritePre * call <SID>remove_dust()
  au BufEnter    * let b:remove_dust_enable = g:remove_dust_enable
augroup END
