
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'

export MPD_HOST="arch-xmonad"

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi
PS1='[\[\e[1;36m\]\u\[\e[0;37m\]@\[\e[1;30m\]\h \[\e[0;37m\W\]]\$ '
