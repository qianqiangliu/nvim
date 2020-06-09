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

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-syntastic/syntastic'
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

" airline
let g:airline_powerline_fonts = 1

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

nmap <F5> : FixWhitespace<CR>
nmap <F6> : !ctags -R -f .tags<CR>
