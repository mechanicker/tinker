PS1='\u@\h \w\n[\!]$ '

PS1="\e[0;31m\h:\e[m\e[0;36m\w\e[m\n$ "

alias h=history
alias vi=vim
alias ls='ls -CF'
alias md='mkdir -p'
alias cls=clear
alias cdgo='pushd ${GOPATH:-"."}'

# FIXME: Figure out how to set unlimited core files size
ulimit -c 0
