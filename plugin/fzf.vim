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
  let full_path = s:root.'/'.get(lines, 0)
  call s:edit(full_path)
  call delete(s:tmpfile)
endfunction

function! s:echoerr(msg) abort
  echohl ErrorMsg
  echomsg a:msg
  echohl None
endfunction

function! s:fzf_open(path) abort
  if !executable('fzf')
    call s:echoerr("You need to install 'fzf' first")
    return
  endif

  let s:root = a:path != '' ? a:path : s:find_root()
  if s:root != '.'
    execute 'lcd '.s:root
  endif

  let width = 80
  let height = 24
  let buf = nvim_create_buf(v:false, v:true)
  let ui = nvim_list_uis()[0]

  let options = {
    \ 'relative': 'editor',
    \ 'width': width,
    \ 'height': height,
    \ 'col': (ui.width / 2) - (width / 2),
    \ 'row': (ui.height / 2) - (height / 2),
    \ 'anchor': 'NW',
    \ 'border': 'rounded',
    \ 'style': 'minimal',
    \ }
  let win = nvim_open_win(buf, 1, options)
  call termopen('fzf --reverse > '.s:tmpfile, { 'on_exit': 's:on_exit' })
  startinsert
endfunction

command! -nargs=? -complete=file Fzf :call s:fzf_open(<q-args>)

nnoremap <C-p> :Fzf<CR>
