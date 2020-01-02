PS1="\e[0;31m\h:\e[m\e[0;36m\w\e[m\n$ "
EPHEMERAL=${EPHEMERAL:-~/.emacs.d}

alias h=history
alias vi=vim
alias ls='ls -CF'
alias md='mkdir -p'
alias rg='ag -S -f'
alias cls=clear
alias cdgo='pushd ${GOPATH:-"."}'
alias em="emacsclient -q -a emacs -t -f ${EPHEMERAL}/server/emacs.server"
alias venv='python3 -m venv'

# FIXME: Figure out how to set unlimited core files size
ulimit -c 0
