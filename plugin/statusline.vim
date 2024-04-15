" Location:     plugin/statusline.vim
" Maintainer:   Qianqiang Liu <qianqiangliu@hotmail.com>
" Version:      1.0

if exists('g:loaded_statusline') || &cp
    finish
endif
let g:loaded_statusline = 1

let g:currentmode = {
  \ 'n'      : 'Normal',
  \ 'i'      : 'Insert',
  \ 'c'      : 'Command',
  \ 'v'      : 'Visual',
  \ 'V'      : 'V·Line',
  \ "\<C-V>" : 'V·Block',
  \ 'R'      : 'Replace',
  \ 't'      : 'Terminal'
  \ }

set noshowmode
set statusline=
set statusline+=%1*\ %{toupper(g:currentmode[mode()])}\  " The current mode
set statusline+=%7*                                     " Separator
set statusline+=%2*\ %<%t%m%r%h%w\                       " Filename, modified, readonly, helpfile, preview
set statusline+=%8*                                     " Separator
set statusline+=%3*\ %Y\                                 " FileType
set statusline+=%4*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%9*                                     " Separator
set statusline+=%1*\ %p%%\ \ %l:%v\                     " Percentage of document, line number / colomn number

function! s:highlight_init()
  au InsertEnter * hi User1 guifg=#282828 guibg=#83a598 ctermfg=235 ctermbg=109
  au InsertEnter * hi User7 guifg=#83a598 guibg=#504945 ctermfg=109 ctermbg=239
  au InsertEnter * hi User9 guifg=#83a598 guibg=#3c3836 ctermfg=109 ctermbg=237
  au InsertLeave * hi User1 guifg=#282828 guibg=#a89984 ctermfg=235 ctermbg=246
  au InsertLeave * hi User7 guifg=#a89984 guibg=#504945 ctermfg=246 ctermbg=239
  au InsertLeave * hi User9 guifg=#a89984 guibg=#3c3836 ctermfg=246 ctermbg=237

  hi User1 guifg=#282828 guibg=#a89984 ctermfg=235 ctermbg=246
  hi User2 guifg=#a89984 guibg=#504945 ctermfg=246 ctermbg=239
  hi User3 guifg=#a89984 guibg=#3c3836 ctermfg=246 ctermbg=237
  hi User4 guifg=#a89984 guibg=#3c3836 ctermfg=246 ctermbg=237
  hi User7 guifg=#a89984 guibg=#504945 ctermfg=246 ctermbg=239
  hi User8 guifg=#504945 guibg=#3c3836 ctermfg=239 ctermbg=237
  hi User9 guifg=#a89984 guibg=#3c3836 ctermfg=246 ctermbg=237
endfunction

augroup colorscheme_change
  autocmd!
  autocmd ColorScheme * call <sid>highlight_init()
augroup END

call s:highlight_init()
