#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh

alias v='nvim'
alias sv='sudo neovim'
alias next-rel='semver `git tag | tail -n 1` -i'
alias ls='ls --color=auto'
PS1='\n\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)$(__git_ps1 "(%s) ")\n\$ '

eval `dircolors -b ~/.dir_colors`
