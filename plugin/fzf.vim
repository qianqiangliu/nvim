" Location:     plugin/fzf.vim
" Maintainer:   Qianqiang Liu <qianqiangliu@hotmail.com>
" Version:      1.0

if exists('g:loaded_fzf') || &cp
  finish
endif
let g:loaded_fzf = 1

function! s:find_root() abort
  let result = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    return substitute(result, '\n*$', '', 'g')
  endif

  return "."
endfunction

function! s:edit(path) abort
  if filereadable(a:path)
    while &buftype != ""
      execute 'wincmd w'
    endwhile
    execute 'edit '.a:path
  endif
endfunction

let s:tmpfile = tempname()

function! s:on_exit(job, status, event) abort
  silent! close

  let lines = readfile(s:tmpfile, '')
  let path = get(lines, 0)
  call s:edit(path)
  call delete(s:tmpfile)
endfunction

function! s:echoerr(msg) abort
  echohl ErrorMsg
  echomsg a:msg
  echohl None
endfunction

function! s:create_popup(opts) abort
  let buf = nvim_create_buf(v:false, v:true)
  let opts = extend({'relative': 'editor', 'style': 'minimal', 'border': 'rounded'}, a:opts)
  let win = nvim_open_win(buf, v:true, opts)
  silent! call setwinvar(win, '&winhighlight', 'Pmenu:,Normal:Normal')
  call setwinvar(win, '&colorcolumn', '')
  return buf
endfunction

function! s:fzf_open(path) abort
  if !executable('fzf')
    call s:echoerr("You need to install 'fzf' first")
    return
  endif

  if !executable('bat')
    let preview = 'cat {}'
  else
    let preview = 'bat --color=always {}'
  endif

  let root = a:path != '' ? a:path : s:find_root()
  if root != '.'
    execute 'lcd '.root
  endif

  let ui = nvim_list_uis()[0]

  let row = ui.height / 5
  let col = ui.width / 5
  let width = ui.width * 3 / 5
  let height = ui.height * 3 / 5

  call s:create_popup({
    \ 'row': row, 'col': col, 'width': width, 'height': height
  \ })

  call termopen('fzf --reverse --preview "'.preview.'" > '.s:tmpfile, { 'on_exit': 's:on_exit' })
  startinsert
endfunction

command! -nargs=? -complete=file Fzf :call s:fzf_open(<q-args>)

nnoremap <C-p> :Fzf<CR>

" vim: set sw=2 sts=2:
