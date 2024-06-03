# ~/.bashrc: executed by bash(1) for non-login shells

### EXPORT

# Basic
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"

# Manpager (uncomment only one of these)
# export MANPAGER="less"
export MANPAGER="nvim +Man!"

# Path
if [ -d "$HOME/.bin" ]; then
    export PATH="$HOME/.bin:$PATH"
fi

# XDG Base Directory
if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_CACHE_HOME" ]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi
if [ -z "$XDG_DATA_HOME" ]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_STATE_HOME" ]; then
    export XDG_STATE_HOME="$HOME/.local/state"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### HISTORY

export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT='%Y-%m-%d %T '
# No duplicate lines or lines starting with space
export HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
# Save multi-line commands in history as single line
shopt -s cmdhist

### OPTIONS

# Check the window size after each command
shopt -s checkwinsize
# Use glob pattern "**" (all files and zero or more directories)
shopt -s globstar
# Glob matches hidden files/directories
shopt -s dotglob
# Change to named directory
shopt -s autocd
 # Autocorrects cd misspellings
shopt -s cdspell
# Expand aliases
shopt -s expand_aliases

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

### VIM

# Set vi mode (default is emacs mode)
set -o vi

### FUNCTIONS

# Countdown
cdown() {
    local n=$(($1 + 1))
    while [[ $((--n)) -gt  0 ]]
    do
        echo "$n" |  figlet | lolcat && sleep 1
    done
}

### ALIASES

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# vim
alias v='nvim'
alias vim='nvim'

# Convenience
alias c='clear'

# Adding default flags
alias grep='grep --color=auto'
alias df='df -h -x squashfs -x tmpfs -x devtmpfs'
alias free='free -m'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ls/eza
alias l='eza -al --color=always --group-directories-first'
alias ls='eza -al --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -l --color=always --group-directories-first'
alias lt='eza -aT --color=always --group-directories-first'
# for parent directories
alias l.='eza -al --color=always --group-directories-first ../'
alias l..='eza -al --color=always --group-directories-first ../../'
alias l...='eza -al --color=always --group-directories-first ../../../'

# apt
alias sai='sudo apt install'
alias saa='sudo apt auto-remove'
alias sac='sudo apt auto-clean'

# ps
alias psa='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'
alias tag='git tag'
alias newtag='git tag -a'

# Change your default USER shell
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Log out and log back in for change to take effect.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Log out and log back in for change to take effect.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Log out and log back in for change to take effect.'"

# Dotfiles bare git repo
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Alert for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# New aliases...
alias lsmount='mount | column -t'
alias extip='curl icanhazip.com'
alias upgrade='sudo apt update && sudo apt dist-upgrade'

### COMPLETION

# Ignore case for tab completion
bind "set completion-ignore-case on"

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### TOOLS

# Node Version Manager configuration
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

### FLEX

# Obligatory flex
if [ -x /usr/bin/neofetch ]; then
    neofetch
fi

### PROMPT

# Basic colorful prompt
# if tput setaf 1 > /dev/null 2>&1; then
#     export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# fi

# Starship prompt
eval "$(starship init bash)"

