# ~/.bashrc: executed by bash(1) for non-login shells.
# 3 different typeshells in bash: login, normal,and interactive shell.
# Login shells read ~/.profile and interactive shells read ~/.bashrc;
# in our interactive setup, /etc/profile sources ~/.bashrc
# Thus all settings made here will also take effect in a login shell.
# NOTE:It is recommended to make language settings in ~/.profile rather than here
# Since multilingual X sessions not work if LANG is overridden in every subshell.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# See also https://github.com/rcaloras/bash-preexec
export PS1="\[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\$\[\e[m\] "

[[ $- != *i* ]] && return
    # If not running interactively, dont do anything
    # dont put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth   # append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

test -s ~/.bash_aliases && . ~/.bash_aliases || true

xrandr -o normal

############# #    PROMPTUSER Custom Terminal##
ZEN=/run/media/cortex/lin4house/zen
export ZEN
PATH=${ZEN}/app:${ZEN}/os:${ZEN}:/usr/sbin:/usr/local/bin:/usr/bin:/bin
export PATH
echo -n "    _\|/_   "
echo "  $(date "+%A %d %B %Y, %T") "
echo "    z e n     User=${USER}  / Distro=gecko-mate "
echo -n "     o s      "
free -m | awk 'NR==2{printf "Memory= %s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "   Disk Usage= %d/%dGB (%s)\n", $3,$2,$5}'
echo -n "     /|\      "
echo  "_____________ ZEN = ${ZEN} "
echo "Please run 'mount | grep ^/dev/' OR SIMPLY 'd' as an alias"
echo "              See - https://zen~OS/help (Right click, Open Link in Browser)"

alias a='source $HOME/.bash_aliases'
alias za='source ${ZEN}/.bash_aliases.zen'
source ${ZEN}/zen.sh
#--- >%
