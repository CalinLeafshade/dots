#
# ~/.bash_profile
#

export PATH="~/.npm-global/bin:${PATH}:$HOME/bin"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export BROWSER=chromium

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

export PATH="$HOME/.cargo/bin:$PATH"
