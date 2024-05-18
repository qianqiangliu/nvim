if exists('g:loaded_grep')
  finish
endif
let g:loaded_grep = 1

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

command -nargs=+ -complete=file -bar
  \ Grep silent! grep! <args> | cwindow | redraw!

nnoremap <Leader>v :call <SID>grep_word_under_cursor()<CR>

function! s:grep_word_under_cursor()
  let word = expand('<cword>')
  execute 'Grep' word
endfunction
