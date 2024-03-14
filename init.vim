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

colorscheme gruvbox

" jump to last position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
  \   exe "normal! g`\"" |
  \ endif

" keep netrw out of alternate-file
autocmd FileType netrw
  \ setlocal bufhidden=delete

command -nargs=+ -complete=file -bar
  \ Grep silent! grep! <args> | cwindow | redraw!

" list buffers
nnoremap <Leader>b :ls<CR>:b<Space>
" list tags
nnoremap <Leader>l :Tlist<CR>
" ctags
nnoremap <Leader>t :silent !ctags -R -f .tags<CR>
" close quick fix
nnoremap <Leader>c :cclose<CR>
" expand '%%' to current path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
