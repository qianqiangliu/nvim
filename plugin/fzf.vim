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

  function! s:on_exit(job, status, event) abort
    silent! close

    let lines = readfile(s:tmpfile, '')
    let full_path = s:root.'/'.get(lines, 0)
    call s:edit(full_path)
    call delete(s:tmpfile)
  endfunction
else
  function! s:on_exit(...) abort
    silent! close

    let root = getcwd()
    let path = term_getline(s:term_buf, 1)
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

  let s:root = a:path != '' ? a:path : s:find_root()
  if s:root != '.'
    execute 'lcd '.s:root
  endif

  if has('nvim')
    keepalt bo 9 new
    setlocal nonumber
    setlocal norelativenumber

    call termopen('fzf > '.s:tmpfile, {'on_exit':'s:on_exit'})
    startinsert
  else
    hi link Terminal Search
    let s:term_buf = term_start('fzf --reverse', #{hidden: 1, term_finish: 'close', exit_cb: 's:on_exit'})
    let options = {
      \ 'pos': 'center',
      \ 'minwidth': 80,
      \ 'minheight': 24,
      \ 'border': [1, 1, 1, 1],
      \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
      \ 'highlight': 'Fzf',
      \ 'padding': [0, 1, 0, 1],
      \ }
    call popup_create(s:term_buf, options)
  endif
endfunction

"hi Fzf guibg=black

command! -nargs=? -complete=file Fzf :call s:fzf_open(<q-args>)

nnoremap <C-p> :Fzf<CR>
