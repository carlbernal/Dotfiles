call plug#begin('~/.vim/plugged')

" misc
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'psliwka/vim-smoothie'

" vim improvements
Plug 'tpope/vim-vinegar'
Plug 'justinmk/vim-sneak'
Plug 'srstevenson/vim-picker'
Plug 'ludovicchabant/vim-gutentags'

" visual improvements
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'

" colorschemes
Plug 'w0ng/vim-hybrid'

" custom verbs
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'

" custom text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'

" custom commands
Plug 'tpope/vim-fugitive'

" language support
Plug 'sheerun/vim-polyglot'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }

" framework support
Plug 'tpope/vim-rails'
Plug 'niftylettuce/vim-jinja'

call plug#end()

""" settings
set number relativenumber
set hidden
set mouse=a
set clipboard+=unnamedplus
set ruler
set updatetime=300 
set autowrite
let mapleader = "<nop>"

" visual
filetype plugin indent on
syntax on
colorscheme hybrid
set cursorline
set termguicolors
set colorcolumn=80
set guicursor= 
set cmdheight=2
set signcolumn=yes

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set grepprg=ag\ --vimgrep\ $*

" default tabs and indent
set smarttab
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" omni completion
set shortmess+=c

" highlight all occurance of the word under the cursor
autocmd CursorMoved * exe printf('match HiUnderCursor /\V\<%s\>/',
			\ escape(expand('<cword>'), '/\'))

" quickfix window
au FileType qf setlocal nonumber
au FileType qf setlocal norelativenumber
au FileType qf setlocal signcolumn=no
au FileType qf setlocal colorcolumn=
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

""" shortcuts
nnoremap <silent><space><space> :noh<cr>
nnoremap <silent><c-s> :update<cr>
nnoremap <silent><c-h> :bp<cr>
nnoremap <silent><c-l> :bn<cr>
nnoremap == :FormatCode<cr>
nmap R <plug>(coc-rename)

" fuzzy
nmap <silent><c-p> <Plug>(PickerEdit)
nmap <silent><c-o> <Plug>(PickerBuffer)
nmap <silent><c-i> <Plug>(PickerTag)

" javascript overrides
autocmd FileType javascript nnoremap <buffer> == :FormatCode prettier<cr>

" ruby overrides
autocmd FileType ruby nnoremap <buffer> == :call CocAction('format')<cr>

" golang overrides
autocmd FileType go nnoremap <buffer> == :GoFmt<cr>
autocmd FileType go nnoremap <buffer> R :GoRename<cr>

" coc diagnostics
nmap <silent><c-m> <Plug>(coc-diagnostic-next)
nmap <silent><c-n> <Plug>(coc-diagnostic-prev)

" coc goto code navigations
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

""" plugins settings

" python
let g:python_highlight_all = 1
let g:python3_host_prog = "/usr/bin/python3"

" golang
let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_play_open_browser = 0
let g:go_fmt_autosave = 0
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"

" markdown
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,jinja EmmetInstall
let g:user_emmet_leader_key=','

" fuzzy
let g:picker_custom_find_executable = 'ag'
let g:picker_custom_find_flags = 'ag . --silent -l 
            \ --ignore node_modules 
            \ --ignore .git 
            \ --ignore dist 
            \ --ignore target 
            \ --ignore __pycache__ 
            \--ignore build 
            \-g ""'

""" coc settings
let g:coc_global_extensions = [
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-tsserver',
    \ 'coc-pyright',
    \ 'coc-json',
    \ 'coc-sql',
    \ 'coc-css',
    \ 'coc-yaml',
    \ 'coc-go',
    \ 'coc-solargraph',
    \ 'coc-vetur',
    \]

" use tab for completion
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use enter to confirm autocompletion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use preview window for documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

""" color theme helper groups

" search highlighting
hi Search guibg=#343945 guifg=none
hi QuickFixLine guibg=#3b424f guifg=none
hi HiUnderCursor guibg=#3b424f guifg=none
hi! MatchParen guifg=none
