" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'flazz/vim-colorschemes'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kassio/neoterm'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'ryanoasis/vim-devicons'
call plug#end()

set number
set expandtab
set tabstop=2
set shiftwidth=2
let mapleader = ","

let g:python_host_prog = $HOME . '/.pyenv/versions/2.7.16/bin/python'
let g:python3_host_prog = $HOME . '/.pyenv/versions/3.7.4/bin/python'

" map
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap <Space> <C-w>w
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

" joshdick/onedark.vim
colorscheme onedark
" colorscheme gruvbox

" itchyny/lightline.vim
let g:lightline = {'colorscheme': 'onedark'}

" scrooloose/nerdtree
nmap <C-e> :NERDTreeToggle<CR>

" xuyuanp/nerdtree-git-plugin

" majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>

" junegunn/fzf
let g:fzf_layout = { 'up': '~40%', }
nmap <C-p> :History<CR>

" ntpeters/vim-better-whitespace
" highlight ExtraWhitespace ctermbg=yellow

" Yggdroot/indentLine
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" tpope/vim-commentary
" autocmd FileType apache setlocal commentstring=#\ %s

" mbbill/undotree
nmap <F5> :UndotreeToggle<CR>

" sheerun/vim-polyglot

" airblade/vim-gitgutter
set updatetime=100

" SirVer/ultisnips
" honza/vim-snippets
let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsEditSplit="vertical"

" kassio/neoterm
let g:neoterm_autoscroll=1
" let g:neoterm_size=60
" let g:neoterm_default_mod='vertical rightbelow'
let g:neoterm_size=10
let g:neoterm_default_mod='belowright'
tnoremap <silent> <C-w> <C-\><C-n><C-w>
nnoremap <silent> <C-b> :TREPLSendLine<CR>j0
vnoremap <silent> <C-b> V:TREPLSendSelection<CR>'>j0

" easymotion/vim-easymotion
nmap s <Plug>(easymotion-overwin-f2)

" tpope/vim-fugitive

" neoclide/coc.nvim
" :CocList extensions
" :CocInstall coc-python coc-json
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" w0rp/ale
" pip install flake8 hacking yapf isort black pylint autopep8
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_echo_msg_format = '[%code%] [%linter%] %s [%severity%]'
let b:ale_linters = {
\  'python': ['flake8', 'hacking'],
\ }
let b:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'python': ['yapf', 'isort'],
\ }

" maximbaz/lightline-ale
" let g:lightline = {}
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \  'linter_checking': 'left',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \ }
let g:lightline.active = {
      \ 'left': [
      \   [ 'mode', 'paste'],
      \   [ 'readonly', 'filename', 'modified'],
      \   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \ ] }
