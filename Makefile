PYTHON_VERSION ?= 3.11.1
NODE_VERSION ?= v18.13.0

.PHONY: init
init: hwclock \
      system-update \
      install-packages \
      docker \
      wsl-systemd \
      tool \
      shell \
      chezmoi-init \

.PHONY: init-after-reboot
init-after-reboot: language editor

.PHONY: tool
tool: install-binary-tools tldr-update fzf tpm

.PHONY: shell
shell: chsh zimfw

.PHONY: language
language: install-packages-for-pyenv pyenv pyenv-virtualenv python node go

.PHONY: editor
editor: neovim packer neovim-setup

.PHONY: hwclock
hwclock:
	sudo hwclock --hctosys
	date

.PHONY: system-update
system-update:
	sudo apt update
	sudo apt upgrade

.PHONY: install-packages
install-packages:
	sudo apt install graphviz jq nkf pngquant tig zip zsh

.PHONY: install-packages-for-pyenv
install-packages-for-pyenv:
	sudo apt install build-essential libssl-dev zlib1g-dev \
	                 libbz2-dev libreadline-dev libsqlite3-dev curl llvm \
	                 libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

.PHONY: docker
docker:
	sudo apt-get update
	sudo apt-get install ca-certificates curl gnupg lsb-release
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
	  "deb [arch=$(shell dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	  $(shell lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
	sudo usermod -aG docker $(USER)

.PHONY: wsl-systemd
wsl-systemd:
	sudo sh -c "echo '[boot]\nsystemd=true' > /etc/wsl.conf"

.PHONY: chsh
chsh:
	chsh -s $(shell which zsh);\

.PHONY: zimfw
zimfw:
	if [ ! -e ~/.zim ]; then \
	  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh; \
	fi
	$(eval SHELL:=$(shell which zsh))
	source ~/.zim/zimfw.zsh upgrade
	source ~/.zim/zimfw.zsh update

.PHONY: fzf
fzf:
	if [ ! -e ~/.fzf ]; then \
	  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; \
	  ~/.fzf/install; \
	else \
	  cd ~/.fzf && git pull && yes | ./install; \
	fi

.PHONY: tpm
tpm:
	if [ ! -e ~/.tmux/plugins/tpm ]; then \
	  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	else \
	  cd ~/.tmux/plugins/tpm && git pull; \
	fi

.PHONY: pyenv
pyenv:
	if [ ! -e ~/.pyenv ]; then \
	  git clone https://github.com/pyenv/pyenv.git ~/.pyenv; \
	else \
	  cd ~/.pyenv && git pull; \
	fi
	cd ~/.pyenv && src/configure && make -C src

.PHONY: pyenv-virtualenv
pyenv-virtualenv:
	if [ ! -e ~/.pyenv/plugins/pyenv-virtualenv ]; then \
	  git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv; \
	else \
	  cd ~/.pyenv/plugins/pyenv-virtualenv && git pull; \
	fi

.PHONY: python
python:
	pyenv install $(PYTHON_VERSION)
	pyenv global $(PYTHON_VERSION)
	python --version

.PHONY: node
node:
	fnm install $(NODE_VERSION)
	fnm default $(NODE_VERSION)
	node --version

.PHONY: go
go:
	$(eval tmp := $(shell mktemp -d))
	curl -L https://go.dev/dl/$(shell curl -sL https://go.dev/VERSION?m=text).linux-amd64.tar.gz -o $(tmp)/go-linux-amd64.tar.gz
	sudo rm -rf /usr/local/go
	sudo tar -C /usr/local -xzf $(tmp)/go-linux-amd64.tar.gz
	rm -rf $(tmp)
	go version

.PHONY: neovim
neovim:
	@echo before...
	-nvim --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | \
	                              grep browser_download_url | \
	                              grep -m1 nvim-linux64.tar.gz | \
	                              cut -d '"' -f 4))
	curl -sL ${url} -o ${tmp}/nvim-linux64.tar.gz
	tar zxf ${tmp}/nvim-linux64.tar.gz -C ${tmp}
	sudo rm -rf /usr/local/bin/nvim-linux64
	sudo mv ${tmp}/nvim-linux64 /usr/local/bin/
	sudo ln -sf /usr/local/bin/nvim-linux64/bin/nvim /usr/local/bin/nvim
	@echo after...
	rm -rf ${tmp}
	nvim --version

.PHONY: packer
packer:
	if [ ! -e ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then \
	  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim; \
	else \
	  cd ~/.local/share/nvim/site/pack/packer/start/packer.nvim && git pull; \
	fi

.PHONY: neovim-setup
neovim-setup:
	-pyenv virtualenv $(PYTHON_VERSION) neovim
	~/.pyenv/versions/neovim/bin/pip install neovim
	npm install -g neovim
	npm install -g tree-sitter-cli

define _install_binary_tool
	echo $1...
	echo before...
	-$1 --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/$2/releases/latest | \
	                              grep browser_download_url | \
	                              grep -m1 $3 | \
	                              cut -d '"' -f 4))
	if [ $4 = tar.gz ]; then \
	  curl -sL $(url) -o $(tmp)/output.tar.gz; \
	  tar zxf $(tmp)/output.tar.gz -C $(tmp); \
	elif [ $4 = zip ]; then \
	  curl -sL $(url) -o $(tmp)/output.zip; \
	  unzip -q $(tmp)/output.zip -d $(tmp); \
	elif [ $4 = raw ]; then \
	  curl -sL $(url) -o $(tmp)/$1; \
	fi
	$(eval filename := $(shell basename $(url) | sed -e s/.tar.gz// -e s/.zip//)) \
	if [ $5 = A ]; then \
	  sudo mv $(tmp)/$(filename)/$1 /usr/local/bin/; \
	elif [ $5 = B ]; then \
	  sudo mv $(tmp)/$1 /usr/local/bin/; \
	elif [ $5 = C ]; then \
	  sudo mv $(tmp)/$(filename)/bin/$1 /usr/local/bin/; \
	fi
	sudo chmod +x /usr/local/bin/$1
	echo after...
	rm -rf $(tmp)
	$1 --version
endef

.PHONY: install-binary-tools
install-binary-tools:
	@$(call _install_binary_tool,bat,sharkdp/bat,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_binary_tool,chezmoi,twpayne/chezmoi,linux-musl_amd64.tar.gz,tar.gz,B)
	@$(call _install_binary_tool,delta,dandavison/delta,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_binary_tool,fd,sharkdp/fd,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_binary_tool,fnm,Schniz/fnm,fnm-linux.zip,zip,B)
	@$(call _install_binary_tool,gh,cli/cli,linux_386.tar.gz,tar.gz,C)
	@$(call _install_binary_tool,ghq,x-motemen/ghq,ghq_linux_amd64.zip,zip,A)
	@$(call _install_binary_tool,lsd,Peltoche/lsd,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_binary_tool,pastel,sharkdp/pastel,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_binary_tool,rg,BurntSushi/ripgrep,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_binary_tool,starship,starship/starship,x86_64-unknown-linux-musl,tar.gz,B)
	@$(call _install_binary_tool,tldr,dbrgn/tealdeer,tealdeer-linux-x86_64-musl,raw,B)
	@$(call _install_binary_tool,xsv,BurntSushi/xsv,x86_64-unknown-linux-musl,tar.gz,B)
	@$(call _install_binary_tool,zoxide,ajeetdsouza/zoxide,x86_64-unknown-linux-musl,tar.gz,B)

.PHONY: chezmoi-init
chezmoi-init:
	chezmoi init --apply https://github.com/wwmota/dotfiles.git

.PHONY: tldr-update
tldr-update:
	tldr --update
