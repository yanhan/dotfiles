# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh


### User configuration from here

# Prints '^C' when Ctrl-c is pressed.
# From https://vinipsmaker.wordpress.com/2014/02/23/my-zsh-config/
TRAPINT() {
  print -n -u2 '^C'
  return $((128+$1))
}

path+=('/home/yh/bin')
path+=('/home/yh/.cabal/bin')
path+=('/home/yh/haskellsandbox/hakyll-4.4.1.2/.cabal-sandbox/bin')
path+=('/home/yh/haskellsandbox/yesod-bin-1.2.5.1/.cabal-sandbox/bin')
export PATH

export EDITOR='vim'

# Ensure colors in vim work properly when using tmux and not using tmux
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# vi mode configuration.
# This is based on code from:
# - https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/vi-mode/vi-mode.plugin.zsh
# - http://dougblack.io/words/zsh-vi-mode.html

# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi

  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

# Use vim mode for command editing
bindkey -v

# This section is adapted from:
#
#     http://www.bewatermyfriend.org/media/vi-mode.zsh
#
# In command mode, Ctrl-d changes to insert mode
bindkey -M viins '^d' vi-cmd-mode
# In insert mode, Ctrl-d changes to command mode
bindkey -M vicmd '^d' vi-insert
# Remove binding for Escape = vi-cmd-mode
bindkey -r '^['

# Enable usage of `v` key in normal mode to edit the command line
# (standard behaviour) using the text editor specified by the EDITOR
# environment variable
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# --- end of code from oh-my-zsh vi-mode plugin

# Backspace key for vim mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Delete a word using Ctrl-w
bindkey '^w' backward-kill-word
# Ctrl-u; similar functionality as in vim.
# Deletes from beginning of line to cursor.
bindkey '^u' backward-kill-line
# Ctrl-k; deletes everything from cursor till end of line
bindkey '^k' kill-line

# Browse through history using Ctrl-P and Ctrl-N, same functionality as
# up and down cursor keys in Bash
bindkey '^P' up-history
bindkey '^N' down-history

# Similar to Ctrl-r in Bash. Search through command history
bindkey '^r' history-incremental-search-backward

# In Insert Mode, Ctrl-A moves to start of line; Ctrl-e moves to end of line.
# These 2 are emacs key bindings but they are really convenient.
bindkey '^a' vi-beginning-of-line
bindkey '^e' vi-end-of-line
# Insert mode move forward and backward 1 character
bindkey '^f' vi-forward-char
bindkey '^b' vi-backward-char
# Alt-rightarrow = forward word; Alt-leftarrow = backward word
bindkey '^[[1;3C' vi-forward-word
bindkey '^[[1;3D' vi-backward-word

# Use right prompt to display `[NORMAL]` in yellow if we're in
# normal mode
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi





### Original code. Some were originally commented out, some not.

# Path to your oh-my-zsh installation.
# export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

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

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

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
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
