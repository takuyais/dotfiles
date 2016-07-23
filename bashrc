# command history
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# prompt
if [ "${TERM}" = 'xterm-256color' ]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
    if hash git 2>/dev/null; then
        PS1="$PS1"' \[\033[01;33m\]$(__git_ps1)\[\033[00m\]'
    fi
else
    PS1='\u@\h:\w'
    if hash git 2>/dev/null; then
        PS1="$PS1"' $(__git_ps1)'
    fi
fi
PS1="$PS1"'\n\$ '

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM='verbose'
GIT_PS1_DESCRIBE_STYLE='cantains'

case "${TERM}" in
    xterm*|rxvt*)
        PS1="\[\033]0;\u@\h: \w\a\]$PS1"
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
