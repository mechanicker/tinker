FROM debian:unstable

ENV DEBIAN_FRONTEND noninteractive

ENV GOPATH /home/tinker/go
RUN mkdir -p /home/tinker/go

RUN apt-get update --no-install-recommends -y && \
        apt-get install --no-install-recommends -y apt-utils && \
        apt-get upgrade -y && \
        apt-get install -y sudo openssl vim git global make gcc g++ golang gdb strace ripgrep \
        curl redis man-db manpages-dev libc-dev libc6-dev libev-dev libfuse3-dev kmod rustc

RUN useradd tinker -G sudo -m -p `echo tinker | openssl passwd -crypt -stdin`

RUN echo PS1=\'\\u@\\h \\w\\n[\\!]$ \' > ~tinker/.bashrc && \
             echo export GOPATH=/home/tinker/go >> ~tinker/.bashrc && \
             echo export PATH=\$GOPATH/bin:\$PATH >> ~tinker/.bashrc && \
             echo alias ls=\'ls -CF\' >> ~tinker/.bashrc && \
             echo alias vi=\'vim \$\*\' >> ~tinker/.bashrc && \
             echo alias md=\'mkdir -p \$\*\' >> ~tinker/.bashrc

USER tinker
WORKDIR /home/tinker
