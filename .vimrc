syntax on
set shell=bash
set title
set number
set wrapscan
set backspace=indent,eol,start
set enc=utf-8
set fenc=utf-8
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set hlsearch
set incsearch
set wildmenu wildmode=list:full
set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set list
set listchars=trail:_,eol:¬,tab:▸\ 
set foldmethod=syntax

colorscheme desert

let &colorcolumn=join(range(81,1000),",")
highlight ColorColumn ctermbg=234

" See https://code.google.com/p/mintty/wiki/Tips#Mode-dependent_cursor_in_vim
let &t_ti.="\e[1 q"
"let &t_SI.="\e[5 q"
"let &t_EI.="\e[1 q"
"let &t_te.="\e[1 q"

" vundle
if !1 | finish | endif

set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'VundleVim/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'thinca/vim-quickrun'
Bundle 'Townk/vim-autoclose'
Bundle 'grep.vim'
Bundle 'tpope/vim-surround'
Bundle 'Align'
Bundle 'kannokanno/previm'
Bundle 'tyru/open-browser.vim'
Bundle 'taglist.vim'

Bundle 'vim-scripts/gtags.vim'

Bundle 'Shougo/vimproc.vim'

Bundle "Valloric/YouCompleteMe"

Bundle 'jimenezrick/vimerl'
Bundle 'vim-erlang/vim-erlang-tags'

Bundle 'JesseKPhillips/d.vim'

Bundle 'itchyny/lightline.vim'
Bundle 'ctrlpvim/ctrlp.vim'

Bundle 'plasticboy/vim-markdown'

Bundle 'davidhalter/jedi-vim'
Bundle 'jmcantrell/vim-virtualenv'

Bundle 'othree/html5.vim'
Bundle 'mattn/emmet-vim'

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Linux\n"
    Bundle 'justmao945/vim-clang'
  endif
endif

filetype plugin indent on

" change the current dir automatically
" See: http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" nerdtree
map <Leader>n :NERDTree<CR>
map <Leader>N :NERDTreeClose<CR>

" vim-markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.report set filetype=markdown
autocmd FileType markdown set tabstop=4 softtabstop=4 shiftwidth=4

" open-browser.vim
" let g:netrw_nogx = 1 " disable netrw's gw mapping.
nmap <Leader>w <Plug>(openbrowser-smart-search)
vmap <Leader>w <Plug>(openbrowser-smart-search)

" C
autocmd FileType c set tabstop=8 softtabstop=8 shiftwidth=8

" Shell
autocmd FileType sh set tabstop=8 softtabstop=8 shiftwidth=8

" erlang
autocmd BufRead,BufNewFile *.erl set filetype=erlang
autocmd FileType erlang set tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufWritePost *.erl call vimproc#system_bg('~/.vim/bundle/vim-erlang-tags/bin/vim-erlang-tags.erl --otp')

" python
autocmd BufRead,BufNewFile *.kv set filetype=python
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" See [Using Vim with Django](https://code.djangoproject.com/wiki/UsingVimWithDjango)
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" surround
let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}""

" jedi-vim
let g:jedi#completions_command = "<M-Space>"  " Prevent conflict with my Spotlight shutcut key on Mac
let g:jedi#usages_command = "<leader>u" " Prevent conflict NERDTreeOpen map 
""let g:jedi#force_py_version = 3
""autocmd FileType python setlocal completeopt-=preview

