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
set statusline+=\ %{toupper(g:currentmode[mode()])}\  " The current mode
set statusline+=                                     " Separator
set statusline+=\ %<%t%m%r%h%w\                       " Filename, modified, readonly, helpfile, preview
set statusline+=                                     " Separator
set statusline+=\ %Y\                                 " FileType
set statusline+=                                     " Separator
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                            " FileFormat (dos/unix..)
set statusline+=%=                                    " Right Side
set statusline+=                                     " Separator
set statusline+=\ %p%%\ \ %l:%v\                     " Percentage of document, line number / colomn number
