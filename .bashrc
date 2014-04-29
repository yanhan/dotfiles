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

# Remove the error stated here:
# http://stackoverflow.com/questions/22313407/clang-error-unknown-argument-mno-fused-madd-python-package-installation-fa
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments

# Given as part of the installation instructions for the `boot2docker` program:
#   http://docs.docker.io/installation/mac/
#   To connect the docker client to the Docker daemon, please set:
export DOCKER_HOST=tcp://localhost:4243

# Secret stuff

. ~/secret.sh
