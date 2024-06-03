" Location:     plugin/grep.vim
" Maintainer:   Qianqiang Liu <qianqiangliu@hotmail.com>
" Version:      1.0

if exists('g:loaded_grep')
  finish
endif
let g:loaded_grep = 1

set grepprg=rg\ --vimgrep\ --smart-case
set grepformat=%f:%l:%c:%m

command -nargs=+ -complete=file -bar
  \ Grep silent! grep! <args> | cwindow | redraw!

nnoremap <Leader>v :Grep <cword><CR>
