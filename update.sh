#!/bin/bash

readonly is_true=true
readonly is_false=true

if "${is_false}"; then
    echo apt upgrade...
    sudo hwclock --hctosys
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove
fi

if "${is_false}"; then
    echo apt install...
    sudo apt install -y jq neovim nkf pngquant zip zsh
    # for pyenv
    sudo apt install -y make build-essential libssl-dev zlib1g-dev \
                        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
                        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    # chsh -s $(which zsh)
fi

# zimfw
if "${is_false}"; then
    echo zimfw...
    if [ ! -e ~/.zim ]; then
        curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    else
        echo zimfw is alerady installed.
    fi
    source ${HOME}/.zim/init.zsh
    zimfw upgrade
    zimfw update
fi

# fzf
if "${is_false}"; then
    echo fzf...
    if [ ! -e ~/.fzf ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    else
        cd ~/.fzf && git pull && yes | ./install
    fi
fi

# pyenv
if "${is_false}"; then
    echo pyenv...
    if [ ! -e ~/.pyenv ]; then
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        cd ~/.pyenv && src/configure && make -C src
    else
        cd ~/.pyenv && git pull
    fi
fi

# pyenv-virtualenv
if "${is_false}"; then
    echo pyenv-virtualenv...
    if [ ! -e ~/.pyenv/plugins/pyenv-virtualenv ]; then
        git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    else
        cd ~/.pyenv/plugins/pyenv-virtualenv && git pull
    fi
fi

# neovim
if "${is_false}"; then
    echo neovim...
    echo before...
    nvim --version
    tmp=`mktemp -d`
    url=`curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep browser_download_url | grep -m1 nvim-linux64.tar.gz | cut -d '"' -f 4`
    curl -sL ${url} -o ${tmp}/nvim-linux64.tar.gz
    tar zxf ${tmp}/nvim-linux64.tar.gz -C ${tmp}
    sudo rm -rf /usr/local/bin/nvim-linux64
    sudo mv ${tmp}/nvim-linux64 /usr/local/bin/
    sudo ln -sf /usr/local/bin/nvim-linux64/bin/nvim /usr/local/bin/nvim
    echo after...
    rm -rf ${tmp}
    nvim --version
fi

# packer.nvim
if "${is_false}"; then
    echo packer.nvim...
    if [ ! -e ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    else
        cd ~/.local/share/nvim/site/pack/packer/start/packer.nvim && git pull
    fi
fi

function download_rust_tool(){
    echo $1...
    echo before...
    $1 --version
    tmp=`mktemp -d`
    url=`curl -s https://api.github.com/repos/$2/releases/latest | grep browser_download_url | grep -m1 x86_64-unknown-linux-musl | cut -d '"' -f 4`
    curl -sL ${url} -o ${tmp}/output.tar.gz
    tar zxf ${tmp}/output.tar.gz -C ${tmp}
    filename=$(basename -- "${url}")
    if [ $3 == 'A' ]; then
        sudo mv ${tmp}/${filename/.tar.gz/}/$1 /usr/local/bin/
    elif [ $3 == 'B' ]; then
        sudo mv ${tmp}/$1 /usr/local/bin/
    fi
    echo after...
    rm -rf ${tmp}
    $1 --version
}

# rust tools
if "${is_false}"; then
    download_rust_tool rg BurntSushi/ripgrep A
    download_rust_tool xsv BurntSushi/xsv B
    download_rust_tool bat sharkdp/bat A
    download_rust_tool fd sharkdp/fd A
    download_rust_tool pastel sharkdp/pastel A
    download_rust_tool delta dandavison/delta A
    download_rust_tool lsd Peltoche/lsd A
    download_rust_tool starship starship/starship B
    download_rust_tool zoxide ajeetdsouza/zoxide B
fi

# fnm
# tldr
# ghq
