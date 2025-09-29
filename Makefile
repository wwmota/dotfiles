# Usage
# $ sudo apt install make
# $ mkdir -p ~/.ghq/github.com/wwmota && cd ~/.ghq/github.com/wwmota && git clone https://github.com/wwmota/dotfiles && cd dotfiles
# $ make init
# $ exit
# $ cd ~/.ghq/github.com/wwmota/dotfiles
# $ make update
# $ exit

# target                 init update
# apt-update             OK   OK
# apt-install            OK
# chsh                   OK
# docker                 OK
# python                 OK   OK     tools, languages
# node                   OK   OK     tools, languages
# sheldon                OK   OK     tools
# sheldon-plugins-update OK   OK     tools
# fzf                    OK   OK     tools
# uv                     OK   OK     tools
# uv-tool                OK   OK     tools
# volta                  OK   OK     tools
# rust-tools             OK   OK     tools
# tldr-update            OK   OK     tools
# neovim                 OK   OK     tools
# lazy                   OK   OK     tools

PYTHON_VERSION ?= 3.13.7
NODE_VERSION ?= v22.19.0

.PHONY: init
init: wsl-systemd \
      apt-update \
      apt-install \
      docker \
      sheldon \
      uv \
      volta \
      chezmoi-init \
      chsh

.PHONY: update
update: apt-update \
        tools \
        chezmoi-update

.PHONY: tools
tools: sheldon \
       sheldon-plugins-update \
       fzf \
       uv \
       python \
       volta \
       node \
       npm \
       uv-tool \
       rust-tools \
       tldr-update \
       neovim \
       lazy

.PHONY: languages
languages: python \
           node

.PHONY: apt-update
apt-update:
	sudo apt update
	sudo apt upgrade
	sudo apt autoremove
	sudo apt autoclean

.PHONY: wsl-systemd
wsl-systemd:
	sudo sh -c "echo '[boot]\nsystemd=true' >> /etc/wsl.conf"

.PHONY: apt-install
apt-install:
	sudo apt install -y nkf htop jq luarocks pngquant sqlite3 tig tmux tree unzip zip zsh

.PHONY: chsh
chsh:
	chsh -s $(shell which zsh)

.PHONY: sheldon
sheldon:
	curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin --force

.PHONY: sheldon-plugins-update
sheldon-plugins-update:
	sheldon lock --update

.PHONY: docker
docker:
	sudo apt update
	sudo apt install -y ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc
	echo \
		"deb [arch=$(shell dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
		$(shell grep '^UBUNTU_CODENAME=' /etc/os-release | cut -d= -f2) stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo usermod -aG docker $(USER)

.PHONY: fzf
fzf:
	if [ ! -e ~/.fzf ]; then \
	  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; \
	  ~/.fzf/install --all; \
	else \
	  cd ~/.fzf && git pull && yes | ./install; \
	fi

.PHONY: uv
uv:
	if [ ! -e ~/.local/bin/uv ]; then \
	  curl -LsSf https://astral.sh/uv/install.sh | sh; \
	else \
	  uv self update; \
	fi

PYTHON_TOOLS = mypy pre-commit ruff
.PHONY: uv-tool
uv-tool:
	@for tool in $(PYTHON_TOOLS); do \
	  if [ ! -e ~/.local/bin/$$tool ]; then \
	    uv tool install "$$tool"; \
		else \
	    uv tool upgrade "$$tool"; \
		fi; \
	done
	uv tool list

.PHONY: python
python:
	uv python install $(PYTHON_VERSION)

.PHONY: volta
volta:
	if [ ! -e ~/.volta/bin/volta ]; then \
	  curl https://get.volta.sh | bash; \
	else \
	  curl https://get.volta.sh | bash -s -- --skip-setup; \
	fi

.PHONY: node
node:
	volta install node@$(NODE_VERSION)

.PHONY: npm
npm:
	npm install -g npm

define _install_rust_tool
	echo $1...
	echo before...
	-$1 --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/$2/releases/latest | \
	                              grep browser_download_url | \
	                              grep -m1 $3 | \
	                              cut -d '"' -f 4))
	if [ $4 = tar.gz ]; then \
	  curl -L $(url) -o $(tmp)/output.tar.gz; \
	  tar zxf $(tmp)/output.tar.gz -C $(tmp); \
	elif [ $4 = tar.xz ]; then \
	  curl -L $(url) -o $(tmp)/output.tar.xz; \
	  tar -xf $(tmp)/output.tar.xz -C $(tmp); \
	elif [ $4 = zip ]; then \
	  curl -L $(url) -o $(tmp)/output.zip; \
	  unzip -q $(tmp)/output.zip -d $(tmp); \
	elif [ $4 = raw ]; then \
	  curl -L $(url) -o $(tmp)/$1; \
	fi
	$(eval filename := $(shell basename $(url) | sed -e s/.tar.gz// -e s/.tar.xz// -e s/.zip//)) \
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

.PHONY: rust-tools
rust-tools:
	@$(call _install_rust_tool,bat,sharkdp/bat,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_rust_tool,chezmoi,twpayne/chezmoi,linux-musl_amd64.tar.gz,tar.gz,B)
	@$(call _install_rust_tool,delta,dandavison/delta,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_rust_tool,fd,sharkdp/fd,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_rust_tool,gh,cli/cli,linux_386.tar.gz,tar.gz,C)
	@$(call _install_rust_tool,ghq,x-motemen/ghq,ghq_linux_amd64.zip,zip,A)
	@$(call _install_rust_tool,lsd,lsd-rs/lsd,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_rust_tool,pastel,sharkdp/pastel,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_rust_tool,rg,BurntSushi/ripgrep,x86_64-unknown-linux-musl,tar.gz,A)
	@$(call _install_rust_tool,starship,starship/starship,x86_64-unknown-linux-musl,tar.gz,B)
	@$(call _install_rust_tool,tldr,tealdeer-rs/tealdeer,tealdeer-linux-x86_64-musl,raw,B)
	@$(call _install_rust_tool,watchexec,watchexec/watchexec,x86_64-unknown-linux-musl.tar.xz,tar.xz,A)
	@$(call _install_rust_tool,xsv,BurntSushi/xsv,x86_64-unknown-linux-musl,tar.gz,B)
	@$(call _install_rust_tool,zoxide,ajeetdsouza/zoxide,x86_64-unknown-linux-musl,tar.gz,B)

.PHONY: tldr-update
tldr-update:
	tldr --update

.PHONY: neovim
neovim:
	@echo before...
	-nvim --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | \
	                              grep browser_download_url | \
	                              grep -m1 nvim-linux-x86_64.tar.gz | \
	                              cut -d '"' -f 4))
	curl -L ${url} -o ${tmp}/nvim-linux-x86_64.tar.gz
	tar zxf ${tmp}/nvim-linux-x86_64.tar.gz -C ${tmp}
	sudo rm -rf /usr/local/bin/nvim-linux-x86_64
	sudo mv ${tmp}/nvim-linux-x86_64 /usr/local/bin/
	sudo ln -sf /usr/local/bin/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
	@echo after...
	rm -rf ${tmp}
	nvim --version

.PHONY: lazy
lazy:
	nvim --headless "+Lazy! sync" +qa

.PHONY: neovim-setup
neovim-setup:
	npm install -g neovim
#	npm install -g tree-sitter-cli
#	-pyenv virtualenv $(PYTHON_VERSION) neovim
#	~/.pyenv/versions/neovim/bin/pip install neovim

.PHONY: chezmoi-init
chezmoi-init:
	sh -c "$$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/wwmota/dotfiles.git
	rm -rf ./bin

.PHONY: chezmoi-init-command
chezmoi-init-command:
	chezmoi init --apply https://github.com/wwmota/dotfiles.git

.PHONY: chezmoi-update
chezmoi-update:
	chezmoi update --force

.PHONY: chezmoi-usage
chezmoi-usage:
	@echo chezmoi update
	@echo chezmoi add path/to/dotfile1
	@echo chezmoi edit path/to/dotfile_or_symlink
	@echo chezmoi diff
	@echo chezmoi -v apply
	@echo chezmoi cd
	@echo git add
	@echo git commit
	@echo git push

.PHONY: aws-cli
aws-cli:
	@echo before...
	-aws --version
	$(eval tmp := $(shell mktemp -d))
	curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o $(tmp)/awscliv2.zip
	unzip -q $(tmp)/awscliv2.zip -d $(tmp)
	sudo $(tmp)/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
	@echo after...
	rm -rf $(tmp)
	aws --version
