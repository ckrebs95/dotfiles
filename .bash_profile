#!/bin/bash
alias ll="ls -alG"
alias ls="ls -G"
alias cdcn="cd ~/src/CoolNet"
alias cdcp="cd ~/src/CoolPOS"
alias cd..="cd .."
alias cls="clear"
alias pdev="./script/deploy_ck.sh"
alias emacs='emacs -nw'
alias edit='emacs -nw'

export PATH=~/bin:/usr/local/bin:$PATH
export EDITOR=emacs

function parse_git_branch {

        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'

}

function proml {

  local        BLUE="\[\033[0;34m\]"

# OPTIONAL - if you want to use any of these other colors:

  local         RED="\[\033[0;31m\]"

  local   LIGHT_RED="\[\033[1;31m\]"

  local       GREEN="\[\033[0;32m\]"

  local LIGHT_GREEN="\[\033[1;32m\]"

  local       WHITE="\[\033[1;37m\]"

  local  LIGHT_GRAY="\[\033[0;37m\]"

# END OPTIONAL

  local     DEFAULT="\[\033[0m\]"

  #export PS1="[\u@\h:\w]\$ "

  PS1="$BLUE|\[\$(date +%H:%M:%S)\]| ${debian_chroot:+($debian_chroo)t}\[\033[38;5;196m\]\u@\h\[\033[00m\]:\w$LIGHT_GREEN\$(parse_git_branch)$DEFAULT\$ "

}
proml
eval `keychain --eval id_rsa`
tmux attach

