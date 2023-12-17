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

if has('nvim')
  let s:tmpfile = tempname()

  function! OpenFile(job, status, event) abort
    silent! bd

    let lines = readfile(s:tmpfile, '')
    let full_path = s:root.'/'.get(lines, 0)
    call s:edit(full_path)
    call delete(s:tmpfile)
  endfunction
else
  function! OpenFile(...) abort
    let root = getcwd()
    let path = term_getline(b:term_buf, 1)

    silent! close

    let full_path = root.'/'.path
    call s:edit(full_path)
  endfunction
endif

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

  keepalt bo 9 new
  setlocal nonumber
  setlocal norelativenumber

  let s:root = a:path != '' ? a:path : s:find_root()
  if s:root != '.'
    execute 'lcd '.s:root
  endif

  if has('nvim')
    call termopen('fzf > '.s:tmpfile, {'on_exit':'OpenFile'})
    startinsert
  else
    let options = {'term_name':'FZF','curwin':1,'exit_cb':'OpenFile'}
    let b:term_buf = term_start('fzf', options)
  endif
endfunction

command! -nargs=? -complete=file Fzf :call s:fzf_open(<q-args>)

nnoremap <C-p> :Fzf<CR>
