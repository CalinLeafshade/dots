#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

alias p='sudo pacman'
alias pu='sudo pacman -Syu'
alias pi='sudo pacman -S'
alias v='nvim'
alias sv='sudo nvim'
alias next-rel='semver `git tag | tail -n 1` -i'
alias ls='ls --color=auto'
PS1='\n\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h:\[$(tput sgr0)\]\[\033[38;5;14m\][\w]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)$(__git_ps1 "(%s) ")\n\$ '

eval `dircolors -b ~/.dir_colors`
