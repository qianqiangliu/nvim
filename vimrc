set number
set numberwidth=1
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set mouse=v
set tags=./.tags;,.tags

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'bronson/vim-trailing-whitespace'
call plug#end()

" nerdtree
let NERDChristmasTree=1
let NERDTreeHightCursorline=0
let NERDTreeMinimalUI=1
let NERDTreeHighlightCursorline=0
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
nmap <F7> : NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdcommentor
let NERDSpaceDelims=1

" tagbar
let g:tagbar_compact=1
let g:tagbar_iconchars=['+', '-']
let g:tagbar_sort=0
let g:tagbar_indent=0
let g:tagbar_autofocus=1
nmap <F8> : TagbarToggle<CR>

nmap <F5> : FixWhitespace<CR>
nmap <F6> : !ctags -R -f .tags<CR>
