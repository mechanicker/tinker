PS1="\e[0;31m\h:\e[m\e[0;36m\w\e[m\n$ "
EPHEMERAL=${EPHEMERAL:-~/.emacs.d}

alias h=history
alias ls='ls -CF'
alias md='mkdir -p'
alias rg='ag -S -f'
alias cls=clear
alias cdgo='pushd ${GOPATH:-"."}'
alias em="emacsclient -q -a emacs -t -f ${EPHEMERAL}/server/emacs.server"
alias venv='python3 -m venv'

PATH=${HOME}/installs/${OS}/bin:${PATH}

# Check if we have neovim installed
test nvim 1>/dev/null
if [ $? -eq 0 ]; then
    alias vi='nvim'
    alias vimdiff='nvim -d'
else
    alias vi='vim'
fi

# FIXME: Figure out how to set unlimited core files size
ulimit -c 0

function perf_setup() {
    if [ ! -f /tmp/.debugfs.mounted ]; then
	sudo mount -t debugfs -omode=755 nodev /sys/kernel/debug
	sudo ls /sys/kernel/debug/tracing 2>&1>/dev/null
	sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
	touch /tmp/.debugfs.mounted
	return
    fi
}

