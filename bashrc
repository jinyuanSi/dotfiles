# .bashrc

export PATH=/usr/local/bin:$PATH

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
set -o vi

export EDITOR=`which vim | head -1`
export VISUAL=`which vim | head -1`
export FCEDIT=`which vim | head -1`

export SHELL='/bin/bash'

export JAVA_HOME=/usr/java/jdk-9.0.1

GROOVY_PATH=/opt/groovy-2.4.10/bin
IDEA_PATH=/opt/idea-IC-171.3780.107/bin
QT4_64_PATH=/usr/lib64/qt4/bin
QT4_PATH=/usr/lib/qt4/bin

export PATH=~/bin:"${JAVA_HOME}/bin:${PATH}:${GROOVY_PATH}:${IDEA_PATH}:${QT4_64_PATH}:${QT4_PATH}:/usr/local/go/bin"

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

if command -v __git_ps1 &>/dev/null; then
    PS1='[\[\e[36;2m\]\u \[\e[31;1m\]\W\[\e[32;1m\]$(__git_ps1 "(%s)")\[\e[0m\]]\[\e[33;1m\]\$\[\e[0m\]'
else
    PS1='[\[\e[36;2m\]\u \[\e[31;1m\]\W\[\e[0m\]]\[\e[33;1m\]\$\[\e[0m\]'
fi

alias ll='ls -rthl --color=auto'

if [ -f ~/.bashrc.alias.servers ]; then
    source ~/.bashrc.alias.servers
fi
