PS1='\u@\h \w\n[\!]$ '

export PATH=$GOPATH/bin:$PATH

alias ls='ls -CF'
alias vi='vim'
alias md='mkdir -p'
alias cls=clear
alias host='pushd ~/host'
alias emacs='HOME=~/host emacs'

# FIXME: Figure out how to set unlimited core files size
ulimit -c 0
