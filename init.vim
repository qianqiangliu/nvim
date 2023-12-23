set number
set numberwidth=1
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set clipboard=unnamed
set tags+=./.tags;,.tags
set matchpairs+=<:>
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
set incsearch
set mouse=
set wildmenu
set cursorline
set background=dark
syntax on

colorscheme gruvbox

" jump to last position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
  \   exe "normal! g`\"" |
  \ endif

command -nargs=+ -complete=file -bar
  \ Grep silent! grep! <args> | cwindow | redraw!

" list buffers
nnoremap <Leader>b :ls<CR>:b<Space>
" expand '%%' to current path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
