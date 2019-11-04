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

# TODO vim: pathogen install
# TODO zsh: install ohmyzsh
# TODO venv: pip install virtualenvwrapper
# TODO brew: install brew
# TODO rvm: install rvm
#
# TODO rebootstrap ~/.ssh/
# TODO rebootstrap ~/code/
# TODO figlet
# TODO lastpass-universal
# TODO navicat
# TODO remote-desktop-connection
# TODO ssh-add -K <keys>

# All the vim plugins to install
PLUGINS = \
	https://github.com/altercation/vim-colors-solarized.git \
	https://github.com/bling/vim-airline.git                \
	https://github.com/chase/vim-ansible-yaml.git           \
	https://github.com/elzr/vim-json.git                    \
	https://github.com/gmarik/vundle.git                    \
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
	https://github.com/hashivim/vim-vagrant.git             \
	https://github.com/hashivim/vim-packer.git              \
	https://github.com/hashivim/vim-vagrant.git             \

all: packages bin vim link ## ALL THE THINGS

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
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap Homebrew/bundle
	brew bundle

bin: ## Setup ~/bin
	mkdir -p ~/bin
	chmod +x ~/bin/*

vim: ## Setup vimbundles
	@if [ ! -d ~/.vim/autoload ] ; then mkdir -p ~/.vim/autoload ; fi && \
	if [ ! -d ~/.vim/bundle/ ] ; then mkdir -p ~/.vim/bundle/ ; fi && \
	cd ~/.vim/bundle/ && $(foreach plugin,$(PLUGINS), [ -d $(plugin) ] || git clone -q $(plugin) ; )
	cd /tmp && git clone git@github.com:powerline/fonts.git && cd fonts && ./install.sh

brew-dump:  ## True up your Brewfile for brew bundler
	@rm Brewfile ; brew bundle dump

osx-prefs: ## Set OS X preferences
	@defaults write com.apple.finder CreateDesktop -bool false && \
	@defaults write com.apple.desktopservices DSDontWriteNetworkStores true && \
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

test: ## Test
	docker pull koalaman/shellcheck:stable && \
	docker run -v "$PWD:/mnt" koalaman/shellcheck *
