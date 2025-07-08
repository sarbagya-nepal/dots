
#-----------------------------------------------------------------------------------------------------------------------------#
#           .___
#  ____   __| _/  Sarbagya Nepal (Coded-Dolphin)
#_/ ___\ / __ |   https://www.youtube.com/coded-dolphin
#\  \___/ /_/ |   https://github.com/coded-dolphin
# \___  >____ |   
#     \/     \/   My zsh config nothing much to see here pretty standard stuff 
#-----------------------------------------------------------------------------------------------------------------------------#

export XCURSOR_THEME=Graphite-dark-cursors

#Custom Prompt
PROMPT='%F{green} %F{red}| %F{blue}%3~%f %F{cyan}%f  '

#Git Right Side Prompt:
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{red}(%b)%r%f'
zstyle ':vcs_info:*' enable git

#Case Insensitive Tab Completion: 
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# #Oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

#Alias
alias v='nvim'
alias la='exa -la --color=always --group-directories-first --icons'
alias ls='exa -a --color=always --group-directories-first --icons'
alias l='exa --color=always --group-directories-first --icons'
alias :q='exit'
alias :wq='exit'
alias fm='ranger'

#history file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

#Start
fastfetch
