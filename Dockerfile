# vim:expandtab
FROM clearlinux:latest as base

ARG HOME
ARG USER

# Create user and required groups for sudo access
RUN groupadd -r sudo
RUN groupadd -g 20 staff
RUN mkdir -p /etc/sudoers.d
RUN echo "%sudo	ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/visudo
RUN useradd -N -G sudo,staff -g staff -M -d $HOME -p `echo nopass | openssl passwd -crypt -stdin` -o -u 501 $USER
COPY --chown=$USER:staff bashrc /etc/bashrc.default

# Update and install common packages
RUN swupd update
RUN swupd bundle-add man-pages sysadmin-basic os-core-search \
        git make editors dev-utils the_silver_searcher \
        c-basic go-basic rust-basic
RUN swupd clean

FROM base as extras
ARG HOME
ARG USER

# Git build requirements
RUN swupd bundle-add performance-tools devpkg-openssl devpkg-curl devpkg-nghttp2 devpkg-expat
RUN swupd clean

USER $USER
WORKDIR $HOME
