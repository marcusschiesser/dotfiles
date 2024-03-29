" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/plugged'
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" List of All vim plugins you need ----------------{{{
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'klen/python-mode'
Plug 'mbriggs/mark.vim'
Plug 'fatih/vim-go'
Plug 'rjohnsondev/vim-compiler-go'
Plug 'dgryski/vim-godef'
Plug 'vim-jp/vim-go-extra'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'othree/html5.vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'itchyny/lightline.vim'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'ekalinin/Dockerfile.vim'
Plug 'vim-syntastic/syntastic'
" }}}

" All of your Plugins must be added before the following line
call plug#end()

" General VIMRC

filetype plugin indent on
syntax on

set autoindent
set encoding=utf-8
set foldlevelstart=0
set laststatus=2
set modeline
set number
set showtabline=2
set t_Co=256
set backspace=2

let mapleader=","
let maplocalleader="\\"
colorscheme wombat256mod

" Vim Statusline --------------- {{{
set statusline=%f
set statusline+=\ %y
set statusline+=%=
set statusline+=%l
set statusline+=,
set statusline+=%c
set statusline+=:
set statusline+=%L
set statusline+=\[%p%%\]
" }}}


" Global Key Mapping ---------------- {{{

" Key map with leader key
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lbl
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lbl
nnoremap <leader>l" ^i"<esc>$a"<esc>^
nnoremap <leader>l' ^i'<esc>$a'<esc>^
nnoremap <leader>U viwU<esc>
nnoremap <leader>u viwu<esc>
nnoremap <leader>B viw<esc>bvU<esc>
nnoremap <leader>b viwU<esc>viw<esc>bvu<esc>

" normal key map
nnoremap <space> za
nnoremap <F5> :set hls!<cr>
nnoremap <F6> :set paste!<cr>
nnoremap <F7> :set ignorecase!<cr>
nnoremap <F8> :TagbarToggle<cr>

" }}}


" Autocmd Groups -------------------- {{{

" Autocmd Group for python ---------- {{{
augroup filetype_python
    autocmd!
    autocmd BufRead,BufNewFile *.py set filetype=python
    autocmd FileType python :call CheckWidthToOpenTagbar()
    autocmd FileType python set tabstop=4
    autocmd FileType python set shiftwidth=4
    autocmd FileType python set expandtab
    autocmd FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
    autocmd FileType python :call CheckAndLoadTags()
    autocmd FileType python iabbrev pythonHead #!/usr/bin/env python<cr># -*- coding: utf-8 -*-<cr>
    autocmd FileType python let g:pymode_rope_lookup_project=0
    autocmd FileType python setlocal colorcolumn=0
augroup END
" }}}

" Autocmd Group for markdown ---------- {{{
augroup filetype_markdown
    autocmd!
    autocmd BufRead,BufNewFile *.md set ft=mkd
    autocmd BufRead,BufNewFile *.mkd set ft=mkd
    autocmd FileType mkd onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType mkd onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END
" }}}

" Autocmd Group for Vimscript file setting ----------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd BufRead,BufNewFile *.vim set filetype=vim
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim inoreabbrev == ==#
    autocmd FileType vim set tabstop=4
    autocmd FileType vim set shiftwidth=4
    autocmd FileType vim set expandtab
augroup END
" }}}

" Autocmd Group for arduion pde ---------- {{{
augroup filetype_pde
    autocmd!
augroup END
" }}}

" Autocmd Group for Nmap NSE script --------------------- {{{
augroup FileType_nse
    autocmd!
    autocmd BufRead,BufNewFile *.nse set filetype=lua
augroup END
" }}}

" Autocmd Group for YARA ---------------------{{{
augroup FileType_Yara
    autocmd!
    autocmd BufNewFile,BufRead *.yara set filetype=yara
    autocmd BufNewFile,BufRead *.yar set filetype=yara
    autocmd FileType yara set tabstop=4
    autocmd FileType yara set shiftwidth=4
    autocmd FileType yara set expandtab
    autocmd FileType yara set smartindent cinwords=strings:,condition:
augroup END
" }}}

" Autocmd Group for golang --------------------{{{
augroup FileType_GO
    autocmd!
    autocmd BufRead,BufNewFile *.go set filetype=go
    autocmd FileType go :call CheckWidthToOpenTagbar()
    autocmd FileType go set noexpandtab
    autocmd FileType go set tabstop=8
    autocmd FileType go :call CheckAndLoadTags()
    autocmd FileType go iabbrev defineCases testCases := []struct{<cr>}{<cr>{},<cr>}
    autocmd FileType go iabbrev forCases for i, c := range testCases {<cr>}
    autocmd FileType go let g:go_template_autocreate = 0
    autocmd FileType go let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
        \ }
augroup END
" }}}

" Autocmd Group for ASM ----------------------{{{
augroup FileType_ASM
    autocmd!
    autocmd BufRead,BufNewFile *.asm set filetype=asm
    autocmd FileType asm colorscheme pychimp
    autocmd FileType asm set tabstop=8
    autocmd FileType asm set noexpandtab
augroup END
" }}}

" Autocmd Group for html --------------------{{{
augroup FileType_HTML
    autocmd!
    autocmd BufRead,BufNewFile *.html set filetype=html
    autocmd FileType html set tabstop=4
    autocmd FileType html set shiftwidth=4
    autocmd FileType html set expandtab
augroup END
" }}}

" Autocmd Group for TypeScript --------------{{{{
augroup FileType_TypeScript
    autocmd!
    autocmd BufRead,BufNewFile *.ts set filetype=typescript
    autocmd BufRead,BufNewFile *.js set filetype=typescript
    autocmd FileType typescript set tabstop=4
    autocmd FileType typescript set shiftwidth=4
    autocmd FileType typescript set expandtab
    autocmd FileType typescript iabbrev and &&
    autocmd FileType typescript let g:tagbar_type_typescript = {
      \ 'ctagstype': 'typescript',
      \ 'kinds': [
        \ 'c:classes',
        \ 'n:modules',
        \ 'f:functions',
        \ 'v:variables',
        \ 'v:varlambdas',
        \ 'm:members',
        \ 'i:interfaces',
        \ 'e:enums',
      \ ]
      \ }
augroup END
" }}}}

" Autocmd Group for Bash --------------{{{{
augroup FileType_Bash
    autocmd!
    autocmd BufRead,BufNewFile *.sh set filetype=sh
    autocmd FileType sh set tabstop=2
    autocmd FileType sh set shiftwidth=2
    autocmd FileType sh set expandtab
augroup END
" }}}}

" }}}


" User defined Functions ------------- {{{

" Function CheckAndLoadTags ---------- {{{
function! CheckAndLoadTags()
    if file_readable("./tags")
        set tag=tags
    endif
endfunction
" }}}

" Function CheckAndLoadTags ---------- {{{
function! CheckWidthToOpenTagbar()
    if winwidth(0) > 120
        TagbarOpen
    endif
endfunction
" }}}

" }}}
