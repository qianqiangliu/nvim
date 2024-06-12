set number
set relativenumber
set clipboard+=unnamedplus
set tags+=./.tags;,.tags
set matchpairs+=<:>
set cursorline
set termguicolors

colorscheme gruvbox8

let g:netrw_banner = 0

" jump to last position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
  \   exe "normal! g`\"" |
  \ endif

" list buffers
nnoremap <Leader>b :ls<CR>:b<Space>
" close quickfix
nnoremap <C-c> :cclose<CR>
" expand '%%' to current path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
