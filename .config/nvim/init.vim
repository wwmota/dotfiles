" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
call plug#end()

set number

" joshdick/onedark.vim
colorscheme onedark

" itchyny/lightline.vim
let g:lightline = {'colorscheme': 'onedark'}

" scrooloose/nerdtree
nmap <C-e> :NERDTreeToggle<CR>

" majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>
