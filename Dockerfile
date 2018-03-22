FROM debian:unstable

ENV DEBIAN_FRONTEND noninteractive
ENV GOPATH /home/tinker/go

RUN apt-get update --no-install-recommends -y && \
        apt-get install --no-install-recommends -y apt-utils && \
        apt-get upgrade -y && \
        apt-get install -y sudo openssl vim git global clang golang gdb strace libc-dev man-db manpages-dev

RUN useradd tinker -G sudo -m -p `echo tinker | openssl passwd -crypt -stdin`

RUN echo PS1=\'\\u@\\h \\w\\n[\\!]$ \' > ~tinker/.bashrc && \
             echo export GOPATH=/home/tinker/go >> ~tinker/.bashrc && \
             echo export PATH=\$GOPATH/bin:\$PATH >> ~tinker/.bashrc && \
             echo alias ls=\'ls -CF\' >> ~tinker/.bashrc && \
             echo alias vi=\'vim \$\*\' >> ~tinker/.bashrc && \
             echo alias md=\'mkdir -p \$\*\' >> ~tinker/.bashrc

RUN mkdir -p /home/tinker/go && go get -u github.com/monochromegane/the_platinum_searcher/...

USER tinker
WORKDIR /home/tinker
