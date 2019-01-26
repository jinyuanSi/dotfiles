# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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
SHELL='/bin/bash'
LC_ALL=C

set -o vi

EDITOR=`which vim | head -1`
VISUAL=`which vim | head -1`
FCEDIT=`which vim | head -1`

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

if command -v __git_ps1 &>/dev/null; then
    PS1='[\[\e[36;2m\]\u \[\e[31;1m\]\W\[\e[32;1m\]$(__git_ps1 "(%s)")\[\e[0m\]]\[\e[33;1m\]\$\[\e[0m\] '
else
    PS1='[\[\e[36;2m\]\u \[\e[31;1m\]\W\[\e[0m\]]\[\e[33;1m\]\$\[\e[0m\] '
fi

alias ll='ls -rthl --color=auto'

if [ -f ~/.bashrc.alias.servers ]; then
    source ~/.bashrc.alias.servers
fi

unset pathmunge
export PATH PS1 EDITOR VISUAL FCEDIT SHELL HISTTIMEFORMAT LC_ALL
