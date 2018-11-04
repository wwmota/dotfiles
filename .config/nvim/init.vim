" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
call plug#end()

set number

" joshdick/onedark.vim
colorscheme onedark
