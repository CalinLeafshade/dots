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

function nextver() {
    local RE='[^0-9]*\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\)\([0-9A-Za-z-]*\)'
    
    MAJOR=`echo $2 | sed -e "s#$RE#\1#"`
    MINOR=`echo $2 | sed -e "s#$RE#\2#"`
    PATCH=`echo $2 | sed -e "s#$RE#\3#"`

    case "$1" in
        major)
           let MAJOR+=1
            ;;
        minor)
           let MINOR+=1
            ;;
        patch)
           let PATCH+=1
            ;;
    esac

    echo "$MAJOR.$MINOR.$PATCH"
}

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

alias sds='sudo systemctl {start, enable}'
alias p='sudo pacman'
alias pu='sudo pacman -Syu'
alias pi='sudo pacman -S'
alias v='nvim'
alias sv='sudo nvim'
alias next-rel='semver `git tag | tail -n 1` -i'
alias ls='ls --classify --tabsize=0 --group-directories-first --literal --color=auto --show-control-chars --human-readable'
PS1='\n\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h:\[$(tput sgr0)\]\[\033[38;5;14m\][\w]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)$(__git_ps1 "(%s) ")\n\$ '

eval `dircolors -b ~/.dir_colors`
