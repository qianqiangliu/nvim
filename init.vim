set number
set numberwidth=1
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set mouse=
set clipboard+=unnamedplus
set tags+=./.tags;,.tags
set matchpairs+=<:>
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
set termguicolors
set cursorline
set nohidden

colorscheme gruvbox

" jump to last position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
  \   exe "normal! g`\"" |
  \ endif

command -nargs=+ -complete=file -bar
  \ Grep silent! grep! <args> | cwindow | redraw!

command! -nargs=+ Git !git <args>

" list buffers
nnoremap <Leader>b :ls<CR>:b<Space>
" close quick fix
nnoremap <Leader>c :cclose<CR>
" expand '%%' to current path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
