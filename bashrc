export PS1="[\u: \w]$ "

# Setting PATH
PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# For `ls` to have colors when VIM is using Solarized colorscheme
export CLICOLOR=1

alias tmux="TERM=screen-256color-bce tmux"

# For running Linux version of `date` command
alias date=gdate

# For golang
export GOPATH=$HOME/go

# Set JAVA_HOME for Mac OS X
export JAVA_HOME=$(/usr/libexec/java_home)

# Remove the error stated here:
# http://stackoverflow.com/questions/22313407/clang-error-unknown-argument-mno-fused-madd-python-package-installation-fa
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments

# For sphinx-quickstart
# http://stackoverflow.com/questions/10921430/fresh-installation-of-sphinx-quickstart-fails
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

### pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Secret stuff
[ -f $HOME/secret.sh ] && . $HOME/secret.sh
