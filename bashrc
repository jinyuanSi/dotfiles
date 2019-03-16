# .bashrc

# Source global definitions
OS_TYPE=$(uname -s | tr '[:upper:]' '[:lower:]')

pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

pathmunge /usr/local/bin
pathmunge ~/bin

HISTTIMEFORMAT='%F %T '
LC_ALL=C

set -o vi

EDITOR=`which vim | head -1`
VISUAL=`which vim | head -1`
FCEDIT=`which vim | head -1`

# curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

# curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

if command -v __git_ps1 &>/dev/null; then
    PS1='[\[\e[36;2m\]\u \[\e[31;1m\]\W\[\e[32;1m\]$(__git_ps1 "(%s)")\[\e[0m\]]\[\e[33;1m\]\$\[\e[0m\] '
else
    PS1='[\[\e[36;2m\]\u \[\e[31;1m\]\W\[\e[0m\]]\[\e[33;1m\]\$\[\e[0m\] '
fi

if [ "${OS_TYPE}" = "darwin" ]; then
    alias ls='ls -G'
    alias ll='ls -Grthl'
else
    alias ls='ls --color=auto'
    alias ll='ls -rthl --color=auto'
fi

alias git-debug='GIT_TRACE=2 GIT_CURL_VERBOSE=2 GIT_TRACE_PERFORMANCE=2 GIT_TRACE_PACK_ACCESS=2 GIT_TRACE_PACKET=2 GIT_TRACE_PACKFILE=2 GIT_TRACE_SETUP=2 GIT_TRACE_SHALLOW=2 git'

if [ -f ~/.bashrc.alias.servers ]; then
    source ~/.bashrc.alias.servers
fi

unset pathmunge OS_TYPE
export PATH PS1 EDITOR VISUAL FCEDIT SHELL HISTTIMEFORMAT LC_ALL
