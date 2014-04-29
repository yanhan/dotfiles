export PS1="[\u: \w]$ "

# Setting PATH

PATH=/usr/local/opt/mysql/bin:$PATH
PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=$HOME/Library/Haskell/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/apache-maven-3.2.1/bin
PATH=$PATH:$HOME/storm-0.9.0.1/bin

# For `ls` to have colors when VIM is using Solarized colorscheme
export CLICOLOR=1

alias tmux="TERM=screen-256color-bce tmux"

# For running Linux version of `date` command
alias date=gdate

# For golang
export GOPATH=$HOME/go

export JAVA_HOME=$(/usr/libexec/java_home)

# Secret stuff

. ~/secret.sh
