export PS1="[\u: \w]$ "

# Setting PATH

PATH=/usr/local/opt/mysql/bin:$PATH
PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=$HOME/Library/Haskell/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# For `ls` to have colors when VIM is using Solarized colorscheme
export CLICOLOR=1

alias tmux="TERM=screen-256color-bce tmux"

# For running Linux version of `date` command
alias date=gdate

# For golang
export GOPATH=$HOME/go

# Secret stuff

. ~/secret.sh
