" Location:     plugin/fzf.vim
" Maintainer:   Qianqiang Liu <qianqiangliu@hotmail.com>
" Version:      1.0

if exists('g:loaded_fzf') || &cp
  finish
endif
let g:loaded_fzf = 1

function! s:find_root()
  let result = system('git rev-parse --show-toplevel')
  if v:shell_error == 0
    return substitute(result, '\n*$', '', 'g')
  endif

  return "."
endfunction

let s:tmpfile = tempname()

function! s:on_exit(job, status, event)
  silent! bd

  let lines = readfile(s:tmpfile, '')

  let full_path = s:root.'/'.get(lines, 0)
  if filereadable(full_path)
    while &buftype != ""
      execute 'wincmd w'
    endwhile
    execute 'edit '.full_path
  endif

  call delete(s:tmpfile)
endfunction

function! s:fzf_open(path)
  keepalt bo 9 new
  setlocal nonumber
  setlocal norelativenumber

  let s:root = a:path != '' ? a:path : s:find_root()
  if s:root != '.'
    execute 'lcd '.s:root
  endif

  call termopen('fzf > '.s:tmpfile, { 'on_exit': 's:on_exit' })
  startinsert
endfunction

command! -nargs=? -complete=file Fzf :call s:fzf_open(<q-args>)

nnoremap <C-p> :Fzf<CR>
