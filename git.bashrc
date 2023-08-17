# vi: ts=2 sts=2 sw=2 ft=sh
if [[ -n "${MSYSTEM}" ]]; then
  HISTIGNORE+=":"
fi
HISTIGNORE+="ga -u:git dc:git st:gs:tgit st:tgs:tglm:tgdm"

# Prompt
# Inspired by following files.
#   https://github.com/msys2/MSYS2-packages/blob/17ce1e4eaf9b93bd7bd2b6eed25a7defe2fc466c/filesystem/bash.bashrc
#   https://github.com/git-for-windows/build-extra/blob/22bfd3f38a60693e67abda8d205ec5a4cd4f40ce/git-extra/git-prompt.sh
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

# Disable some features due to extremely slow __git_ps1 in windows.
GIT_PS1_SHOWSTASHSTATE=1
#GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM='verbose name'
#GIT_PS1_SHOWCONFLICTSTATE='yes'
GIT_PS1_DESCRIBE_STYLE='contains'

# Alias
if [[ "${OSTYPE}" =~ msys|cygwin ]]; then
  source ~/.aliases_tortoisegit
fi

alias ga="git add"
alias gs="git st"
alias gsw="git sw"
alias gd="git dfs"
alias gdm="git dfs origin/master..."
