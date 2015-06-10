# command history
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# prompt
if [ "${TERM}" = 'xterm-256color' ]; then
    PS1='\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

case "${TERM}" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# alias
case "${OSTYPE}" in
    darwin*)
        alias ls='ls -FG'
        ;;
    msys|cygwin)
        alias ls='ls -F --color=auto --show-control-chars'
        ;;
    linux*)
        alias ls='ls -F --color=auto'
        ;;
esac
alias ll='ls -lA'
alias la='ls -A'

alias grep='grep --color=auto'

stty stop undef
