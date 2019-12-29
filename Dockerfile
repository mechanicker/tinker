FROM clearlinux:latest

RUN swupd bundle-add man-pages sysadmin-basic os-core-search \
	    git make editors dev-utils performance-tools \
	    c-basic go-basic rust-basic

RUN groupadd -r sudo
RUN mkdir -p /etc/sudoers.d
RUN echo "%sudo	ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/visudo

RUN useradd tinker -G sudo -m -p `echo tinker | openssl passwd -crypt -stdin`
USER tinker

COPY --chown=tinker bashrc /home/tinker/.bashrc

RUN mkdir -p /home/tinker/go
ENV GOPATH /home/tinker/go

WORKDIR /home/tinker
