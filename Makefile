SHELL := /bin/bash

help:
	@echo ""
	@echo "help           - show help information"
	@echo "install        - ALL THE THINGS"
	@echo "link           - symlink relevant dotfiles"
	@echo "packages       - tap brew-bundle and install"
	@echo "bin            - get ~/bin/ setup"
	@echo "vim            - setup vim bundles"
	@echo ""

# Inspired by https://github.com/b0d0nne11/dotfiles
install: link packages bin vim

link:
	ln -sf ~/.dotfiles/bashrc					~/.bashrc
	ln -sf ~/.dotfiles/bash_profile		~/.bash_profile
	ln -sf ~/.dotfiles/bash_prompt		~/.bash_prompt
	ln -sf ~/.dotfiles/Brewfile				~/.Brewfile
	ln -sf ~/.dotfiles/gemrc					~/.gemrc
	ln -sf ~/.dotfiles/gitconfig			~/.gitconfig
	ln -sf ~/.dotfiles/ruby-version		~/.ruby-version
	ln -sf ~/.dotfiles/tmux.conf			~/.tmux.conf
	ln -sf ~/.dotfiles/vimrc.conf			~/.vimrc
	ln -sf ~/.dotfiles/zshrc					~/.zshrc

# This assumes the above Brewfile
# http://robots.thoughtbot.com/brewfile-a-gemfile-but-for-homebrew
packages:
	brew tap Homebrew/bundle
	brew bundle

bin:
	mkdir ~/bin
	chmod +x ~/bin/*

vim:
	if [ -d ~/.vim/bundle/ ] ; then mkdir -p ~/.vim/bundle/
	cd ~/.vim/bundle/
	git clone https://github.com/jnurmine/Zenburn.git
	git clone https://github.com/scrooloose/nerdcommenter.git
	git clone https://github.com/scrooloose/nerdtree.git
	git clone https://github.com/powerline/powerline.git
	git clone https://github.com/scrooloose/syntastic.git
	git clone https://github.com/bling/vim-airline
	git clone https://github.com/vadv/vim-chef
	git clone https://github.com/altercation/vim-colors-solarized.git
	git clone https://github.com/tpope/vim-git.git
	git clone https://github.com/nathanaelkane/vim-indent-guides
	git clone https://github.com/tpope/vim-markdown.git
	git clone https://github.com/tpope/vim-sensible.git
	git clone https://github.com/mhinz/vim-signify
	git clone https://github.com/gmarik/vundle.git
	git clone https://github.com/chase/vim-ansible-yaml.git
	git clone https://github.com/elzr/vim-json.git

brew-dump:
	@rm Brewfile ; brew bundle dump

osx:
	@defaults write com.apple.finder CreateDesktop -bool false && \
	killall Finder
