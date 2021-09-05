# vi: ts=2 sts=2 sw=2
# Command history
HISTCONTROL=ignoreboth
HISTIGNORE="\&:ls:ll:pwd:ga -u:git dc:git st:gs:tgit st:tgs:tglm:tgdm"
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=20000

# Prompt
# Inspired by: https://github.com/git-for-windows/MSYS2-packages/blob/master/filesystem/bash.bashrc, git-prompt.sh
if [[ -n "${MSYSTEM}" ]]; then
  # if we have the "High Mandatory Level" group, it means we're elevated
  if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
    then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
    else _ps1_symbol='\$'
  fi
  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\[\e[36m\]`__git_ps1`\[\e[0m\]\n'"${_ps1_symbol}"' '
  unset _ps1_symbol
else
  if [[ "${TERM}" == 'xterm-256color' ]]; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
    if hash git 2>/dev/null; then
      PS1="$PS1"' \[\033[01;33m\]`__git_ps1`\[\033[00m\]'
    fi
  else
    PS1='\u@\h:\w'
    if hash git 2>/dev/null; then
      PS1="$PS1"' `__git_ps1`'
    fi
  fi
  PS1="$PS1"'\n\$ '
fi

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

# Alias
case "${OSTYPE}" in
  darwin*)
    alias ls='ls -FG'
    ;;
  msys|cygwin)
    PATH="${PATH}:$(cygpath "$(cmd /c "echo %LOCALAPPDATA%")")/Programs/Microsoft VS Code/bin"
    alias ls='ls -F --color=auto --show-control-chars'
    alias gvim="'C:/Program Files/Vim/vim82/gvim.exe'"
    source ~/.aliases_tortoisegit
    ;;
  linux*)
    alias ls='ls -F --color=auto'
    ;;
esac
alias ll='ls -lA'
alias la='ls -A'

alias grep='grep --color=auto'
alias xgrep="grep \
--exclude-dir='.svn' \
--exclude-dir='.git' \
--exclude-dir='node_modules' \
--exclude-dir='target' \
--exclude='*.class' \
--exclude='*.map' \
--exclude='app.*.css' \
--exclude='polyfill.*.js' \
--exclude='app.*.js' \
--exclude='vendor.*.js'"

alias svnurl='svn info --show-item=url'

alias ga="git add"
alias gs="git st"
alias gd="git dfs"
alias gdm="git dfs origin/master..."

# winpty: Some programs require a Win32 Console
# Ref.: https://github.com/git-for-windows/build-extra/blob/main/git-extra/aliases.sh
# Ex.: alias node="winpty node.exe"

# Enable key-binding for forward-search-history (C-s)
stty stop undef
