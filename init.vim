set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set clipboard=unnamed
set tags+=./.tags;,.tags
set matchpairs+=<:>
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
set foldmethod=syntax
set nofoldenable

" jump to last position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
  \   exe "normal! g`\"" |
  \ endif

autocmd TermOpen * startinsert

" list buffers
nnoremap <Leader>b :ls<CR>:b<Space>
" expand '%%' to current path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

tnoremap <Esc> <C-\><C-n>
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
