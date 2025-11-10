#   ______      _ _      _____     _    _                                               _____      
#  |  ____|    (_) |    |  __ \   | |  | |                                             / ____|     
#  | |__   _ __ _| | __ | |  | |  | |__| | ___ _ __ _ __ _ __ ___   __ _ _ __  _ __   | (___  _ __ 
#  |  __| | '__| | |/ / | |  | |  |  __  |/ _ \ '__| '__| '_ ` _ \ / _` | '_ \| '_ \   \___ \| '__|
#  | |____| |  | |   <  | |__| |  | |  | |  __/ |  | |  | | | | | | (_| | | | | | | |  ____) | |_  
#  |______|_|  |_|_|\_\ |_____(_) |_|  |_|\___|_|  |_|  |_| |_| |_|\__,_|_| |_|_| |_| |_____/|_(_) 

#  Zsh configuration file, updated 03/04/2025
# ~/.zshrc

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh/
ZSH_CUSTOM=~/.config/zsh/themes

# Set name of the theme to load --- if set to "random", it will
 ZSH_THEME="blueblood"

# Use only the 'main' highlighter
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

# Custom syntax highlighting styles
# set_zsh_highlight_styles(){
# ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'           # valid commands
# ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'              # aliases
# ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'                 # shell builtins (e.g. cd, echo)
# ZSH_HIGHLIGHT_STYLES[function]='fg=brightblue'          # functions
# ZSH_HIGHLIGHT_STYLES[precommand]='fg=magenta'           # sudo, exec, etc.
# ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=brightblack' # the `|` or `;`
# ZSH_HIGHLIGHT_STYLES[arg0]='fg=white'                   # the first argument (can help with scripts)
# ZSH_HIGHLIGHT_STYLES[option]='fg=brightgreen'           # command-line options
# ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'                  # file paths
# ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'             # globs like *.txt
# ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=brightyellow'
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[redirection]='fg=brightmagenta'
# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'       # typos or invalid commands
# }

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

ENABLE_CORRECTION="true"

HIST_STAMPS="mm/dd/yyyy"

export VISUAL=nvim
export EDITOR=nvim

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux jump) 

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

setopt GLOB_DOTS

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

# PS1='[\u@\h \W]\$ '

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# Readable output
alias df='df -h'

# Basic anto/tab completion
autoload -U compinit
zstyle ':completion::' menu select

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Ex = EXtractor for all kinds of archives
# Usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Loads personal aliases from seperate file
[[ -f ~/.zsh_aliases ]] && . ~/.zsh_aliases

bindkey -v
fastfetch 

export PATH="$HOME/bin/scripts/shell_scripts:$PATH"


## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/erik/.dart-cli-completion/zsh-config.zsh ]] && . /home/erik/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

export PIPX_DEFAULT_PYTHON=/usr/bin/python3.11
