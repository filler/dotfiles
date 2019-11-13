.PHONY: all
.SILENT: banner help packages

SHELL := /bin/bash

default: help

help: banner
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

banner:
	echo ""
	echo "         _|              _|          _|_|  _|  _|                    "
	echo "     _|_|_|    _|_|    _|_|_|_|    _|          _|    _|_|      _|_|_|"
	echo "   _|    _|  _|    _|    _|      _|_|_|_|  _|  _|  _|_|_|_|  _|_|    "
	echo "   _|    _|  _|    _|    _|        _|      _|  _|  _|            _|_|"
	echo "     _|_|_|    _|_|        _|_|    _|      _|  _|    _|_|_|  _|_|_|  "
	echo ""

# TODO venv: pip install virtualenvwrapper
# TODO byobu activate
# TODO scream about iterm prefs to Meslo Powerline font?
#
# TODO rebootstrap ~/.ssh/
# TODO rebootstrap ~/code/
# TODO figlet
# TODO lastpass-universal
# TODO navicat
# TODO remote-desktop-connection
# TODO ssh-add -K <keys>
# TODO add shell change - /etc/shells and chsh -s to brew zsh

# All the vim plugins to install
PLUGINS = \
	https://github.com/altercation/vim-colors-solarized.git \
	https://github.com/bling/vim-airline.git                \
	https://github.com/chase/vim-ansible-yaml.git           \
	https://github.com/elzr/vim-json.git                    \
	https://github.com/gmarik/vundle.git                    \
	https://github.com/hashivim/vim-packer.git              \
	https://github.com/hashivim/vim-vagrant.git             \
	https://github.com/jnurmine/Zenburn.git                 \
	https://github.com/mhinz/vim-signify.git                \
	https://github.com/nathanaelkane/vim-indent-guides.git  \
	https://github.com/powerline/powerline.git              \
	https://github.com/scrooloose/nerdcommenter.git         \
	https://github.com/scrooloose/nerdtree.git              \
	https://github.com/scrooloose/syntastic.git             \
	https://github.com/tpope/vim-git.git                    \
	https://github.com/tpope/vim-markdown.git               \
	https://github.com/tpope/vim-sensible.git               \
	https://github.com/vadv/vim-chef.git                    \

all: packages bin ssh vim zsh rvm link ## ALL THE THINGS

link: ## symlink all relevant dotfiles
	ln -sf ~/.dotfiles/bashrc         ~/.bashrc
	ln -sf ~/.dotfiles/bash_profile   ~/.bash_profile
	ln -sf ~/.dotfiles/bash_prompt    ~/.bash_prompt
	ln -sf ~/.dotfiles/Brewfile       ~/.Brewfile
	ln -sf ~/.dotfiles/gemrc          ~/.gemrc
	ln -sf ~/.dotfiles/gitconfig      ~/.gitconfig
	ln -sf ~/.dotfiles/ruby-version   ~/.ruby-version
	ln -sf ~/.dotfiles/tmux.conf      ~/.tmux.conf
	ln -sf ~/.dotfiles/vimrc          ~/.vimrc
	ln -sf ~/.dotfiles/warprc         ~/.warprc
	ln -sf ~/.dotfiles/zshrc          ~/.zshrc

# This assumes the above Brewfile
# http://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew
packages: ## Install homebrew, brew bundle install
	# Check for git installed
	# If not found, give snippets to install
	if [ ! git ] ; then echo "I cannot find git in my $PATH!  Install it?  git --version ..." ; fi
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
	brew tap Homebrew/bundle
	brew bundle

bin: ## Setup ~/bin
	mkdir -p ~/bin

vim: ## Setup vimbundles
	if [ ! -d ~/.vim/autoload ] ; then mkdir -p ~/.vim/autoload ; fi
	if [ ! -d ~/.vim/bundle/ ] ; then mkdir -p ~/.vim/bundle/ ; fi
	cd ~/.vim/bundle/ && $(foreach plugin,$(PLUGINS), git clone -q $(plugin) || true )
	if [ ! -d /tmp/fonts ] ; then cd /tmp && git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh ; fi
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

brew-dump:  ## True up your Brewfile for brew bundler
	@rm Brewfile ; brew bundle dump

osx-prefs: ## Set OS X preferences
	@defaults write com.apple.finder CreateDesktop -bool false && \
	defaults write com.apple.desktopservices DSDontWriteNetworkStores true && \
	killall Finder

osx-update: osx-update-enable osx-update-list osx-update-install ## Apply Apple patches

osx-update-list: ## List all outstanding OS X updates
	@softwareupdate --all --list

osx-update-install: ## Install all outstanding OS X updates
	@softwareupdate --all --recommended --install

osx-update-enable: ## Enable automatic OS X updates
	@echo "Checking into automatic update schedule ..."
	@sudo softwareupdate --schedule
	@echo "Enabling automatic update schedule ..."
	@sudo softwareupdate --schedule on

rvm:  ## Install rvm
ifeq (, $(shell which rvm))
curl -sSL https://get.rvm.io | bash
endif

ssh:  ## Setup ssh subsystem
ifeq (, $(shell grep -q "^github.com" $(HOME)/.ssh/known_hosts))
$(shell ssh-keyscan github.com >> $(HOME)/.ssh/known_hosts)
endif

test: ## Test
	docker pull koalaman/shellcheck:stable && \
	docker run -v "$PWD:/mnt" koalaman/shellcheck *

zsh:  ## Install oh-myzsh
	if [ ! -d ~/.oh-my-zsh ] ; then curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh ; fi
