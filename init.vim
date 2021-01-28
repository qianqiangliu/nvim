set number
set numberwidth=1
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set mouse=v
set tags=./.tags;,.tags
set encoding=utf-8

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-syntastic/syntastic'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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
nmap <F8> : TagbarToggle<CR>

" vim-gutentags
let g:gutentags_project_root = ['.root', '.git']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

nmap <F3> : Files<CR>
nmap <F4> : SyntasticCheck<CR>
nmap <F5> : FixWhitespace<CR>
nmap <F6> : !ctags -R -f .tags<CR>
