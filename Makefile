# .PHONY: all
# all: hwclock \
#      system-update \
#      install-packages \
#      install-packages-for-pyenv \
#      zimfw \
#      chsh \
#      fzf \
# 	 pyenv \
# 	 pyenv-virtualenv \
# 	 chezmoi \
# 	 install-rust-tools \
# 	 docker \

hoge:

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
	sudo apt install jq neovim nkf pngquant tig zip zsh

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

.PHONY: chsh
chsh:
	# if [ "${SHELL}" != "/usr/bin/zsh" ]; then\ 
	chsh -s $(shell which zsh);\
	# fi

.PHONY: zimfw
zimfw:
	if [ ! -e ~/.zim ]; then \
	  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh; \
	fi
	# source ~/.zim/init.zsh
	# zimfw upgrade
	# zimfw update

.PHONY: fzf
fzf:
	if [ ! -e ~/.fzf ]; then \
	  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; \
	  ~/.fzf/install; \
	else \
	  cd ~/.fzf && git pull && yes | ./install; \
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

.PHONY: ghq
ghq:
	@echo before...
	-ghq --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/x-motemen/ghq/releases/latest | grep browser_download_url | grep -m1 ghq_linux_amd64.zip | cut -d '"' -f 4))
	curl -sL $(url) -o $(tmp)/ghq_linux_amd64.zip
	unzip -q $(tmp)/ghq_linux_amd64.zip -d $(tmp)
	sudo mv $(tmp)/ghq_linux_amd64/ghq /usr/local/bin/
	@echo after...
	rm -rf $(tmp)
	ghq --version

.PHONY: chezmoi
chezmoi:
	@echo before...
	-chezmoi --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/twpayne/chezmoi/releases/latest | grep browser_download_url | grep -m1 linux_amd64.tar.gz | cut -d '"' -f 4))
	curl -sL $(url) -o $(tmp)/chezmoi_linux_amd64.tar.gz
	tar zxf $(tmp)/chezmoi_linux_amd64.tar.gz -C $(tmp)
	sudo mv $(tmp)/chezmoi /usr/local/bin/
	@echo after...
	rm -rf $(tmp)
	chezmoi --version

.PHONY: fnm
fnm:
	@echo before...
	-fnm --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/Schniz/fnm/releases/latest | grep browser_download_url | grep -m1 fnm-linux.zip | cut -d '"' -f 4))
	curl -sL $(url) -o $(tmp)/fnm-linux.zip
	unzip -q $(tmp)/fnm-linux.zip -d $(tmp)
	sudo mv $(tmp)/fnm /usr/local/bin/
	sudo chmod +x /usr/local/bin/fnm
	@echo after...
	rm -rf $(tmp)
	fnm --version

define _install_rust_tool
	echo $1...
	echo before...
	-$1 --version
	$(eval tmp := $(shell mktemp -d))
	$(eval url := $(shell curl -s https://api.github.com/repos/$2/releases/latest | grep browser_download_url | grep -m1 x86_64-unknown-linux-musl | cut -d '"' -f 4))
	curl -sL $(url) -o $(tmp)/output.tar.gz
	tar zxf $(tmp)/output.tar.gz -C $(tmp)
	$(eval filename := $(shell basename $(url) | sed s/.tar.gz//))
	if [ $3 = A ]; then \
	  sudo mv $(tmp)/$(filename)/$1 /usr/local/bin/; \
	elif [ $3 = B ]; then \
	  sudo mv $(tmp)/$1 /usr/local/bin/; \
	fi
	echo after...
	rm -rf $(tmp)
	$1 --version
endef

.PHONY: install-rust-tools
install-rust-tools:
	@$(call _install_rust_tool,bat,sharkdp/bat,A)
	@$(call _install_rust_tool,delta,dandavison/delta,A)
	@$(call _install_rust_tool,fd,sharkdp/fd,A)
	@$(call _install_rust_tool,lsd,Peltoche/lsd,A)
	@$(call _install_rust_tool,pastel,sharkdp/pastel,A)
	@$(call _install_rust_tool,rg,BurntSushi/ripgrep,A)
	@$(call _install_rust_tool,starship,starship/starship,B)
	@$(call _install_rust_tool,xsv,BurntSushi/xsv, B)
	@$(call _install_rust_tool,zoxide,ajeetdsouza/zoxide,B)
