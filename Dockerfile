FROM debian:unstable

ENV DEBIAN_FRONTEND noninteractive
ENV GOPATH /home/tinker/go

RUN apt-get update --no-install-recommends -y && \
        apt-get install --no-install-recommends -y apt-utils && \
        apt-get upgrade -y && \
        apt-get install -y sudo openssl vim git global make gcc-8 g++-8 golang gdb strace abootimg \
        redis man-db manpages-dev libc-dev libuv-dev libev-dev

RUN update-alternatives --install `which gcc` gcc `which gcc-8` 50
RUN update-alternatives --install `which gcc|xargs dirname`/g++ g++ `which g++-8` 50

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
