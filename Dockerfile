FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

ENV GOPATH /home/tinker/go
RUN mkdir -p /home/tinker/go

RUN apt-get update --no-install-recommends -y && \
        apt-get install --no-install-recommends -y apt-utils && \
        apt-get upgrade -y && \
        apt-get install -y sudo openssl vim git global make gcc g++ golang gdb strace ripgrep \
        curl redis man-db manpages-dev libc-dev libc6-dev libev-dev libfuse3-dev kmod rustc

RUN useradd tinker -G sudo -m -p `echo tinker | openssl passwd -crypt -stdin`
COPY .bashrc /home/tinker/.bashrc

USER tinker
WORKDIR /home/tinker
