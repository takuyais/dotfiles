# vi: ts=2 sts=2 sw=2
_script_dir="$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")"

# Command history
HISTCONTROL=ignoreboth
HISTIGNORE="\&:ls:ll:pwd"
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=20000

# Prompt
. "${_script_dir}/git.bashrc"
export PS4='+(${BASH_SOURCE}${FUNCNAME:+.$FUNCNAME()}:${LINENO}): '
# If this is an xterm set the title to user@host:dir
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
    PATH="${PATH}:$(cygpath "$(${COMSPEC} /c "echo %LOCALAPPDATA%")")/Programs/Microsoft VS Code/bin"
    alias ls='ls -F --color=auto --show-control-chars'
    alias gvim="'C:/Program Files/Vim/vim90/gvim.exe'"
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

# winpty: Some programs require a Win32 Console
# Ref.: https://github.com/git-for-windows/build-extra/blob/main/git-extra/aliases.sh
# Ex.: alias node="winpty node.exe"

# Enable key-binding for forward-search-history (C-s)
stty stop undef

unset _script_dir
