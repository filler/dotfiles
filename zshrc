# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Jabba
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER="$USER"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Openconnect
alias vpnyes="sudo openconnect vpn.dfw1.rackspace.com -b"
alias vpnno="sudo pkill -SIGINT openconnect"
alias vpnwat="curl -s icanhazip.com | xargs -n1 dig +short -x"
alias vpnvidyo="sudo route -n add 174.143.224.224/27 $(netstat -nr | egrep '^default.*UGScI' | awk {'print $2'})"
alias vpnvidyono="sudo route -n delete 174.143.224.224/27 $(netstat -nr | egrep '^default.*UGScI' | awk {'print $2'})"
alias vpnvidyodel="sudo route -n delete 174.143.224.224/27 $(netstat -nr | egrep '^default.*UGScI' | awk {'print $2'})"

# Homebrew
alias brewup="brew update ; brew upgrade --greedy ; brew cu --no-brew-update --yes --all ; brew cleanup ; brew cleanup"

# No ssh hostkeys
alias hussh="ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"

# lulz
#alias saydone="for i in `say -v \? | awk {'print $1'}` ; do say done -v $i ; done"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github brew osx sublime rsync tmux rbenv jsontools vim-interaction vi-mode vundle rvm wd pyenv)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:$PATH"

#export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# byobu
export BYOBU_PREFIX=$(brew --prefix)

# chef-shell
#eval "$(chef shell-init zsh)"

# ansible-dk
#eval "$(ansible-dk shell-init zsh)"

# added by travis gem
[ -f /Users/silkey/.travis/travis.sh ] && source /Users/silkey/.travis/travis.sh

# time between events - listed in hours
# relies on gnu date from brew - bsd date lololol
tbe () {
  echo $(( ( $(gdate +%s -d "$2") - $(gdate +%s -d "$1") ) / 60 / 60 )) ;
}

# google (gcp) gcloud
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
