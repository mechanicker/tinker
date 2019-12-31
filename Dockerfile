# vim:expandtab
FROM clearlinux:latest

ARG HOME
ARG USER

RUN swupd update
RUN swupd bundle-add man-pages sysadmin-basic os-core-search \
        git make editors dev-utils the_silver_searcher \
        c-basic go-basic rust-basic \
        performance-tools devpkg-openssl devpkg-curl devpkg-nghttp2 devpkg-expat

RUN groupadd -r sudo
RUN groupadd -g 20 staff
RUN mkdir -p /etc/sudoers.d /Users
RUN echo "%sudo	ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/visudo

RUN useradd -N -G sudo,staff -g staff -M -d $HOME -p `echo nopass | openssl passwd -crypt -stdin` -o -u 501 $USER
USER $USER

COPY bashrc /etc/bashrc.default

WORKDIR $HOME
