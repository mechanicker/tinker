# Build a linux docker image

USER := $(shell whoami)
PASSWD ?= "nopass"
HOME := $(shell realpath ~)
FLAVOR := Dockerfile.centos

all: refresh build

centos: FLAVOR=Dockerfile.centos
centos: all

debian: FLAVOR=Dockerfile.debian
debian: all

clearlinux: FLAVOR=Dockerfile.clearlinux
clearlinux: all

refresh:
	@if [ -f linux.latest ] ; then find linux.latest -mtime +7 -exec rm -f {} + ; fi

build: linux.latest

linux.latest: STAGE=$(word 2, $(subst ., , $@))
linux.latest: SOURCE=$(word 2, $(shell grep -m 1 -E "^FROM" ${FLAVOR}))
linux.latest: bashrc Makefile ${FLAVOR}
	@echo Building linux stage ${STAGE} based on ${SOURCE}
	@docker pull ${SOURCE}
	@docker build -q -f ${FLAVOR} --build-arg HOME=${HOME} --build-arg USER=${USER} --build-arg PASSWD=${PASSWD} --tag=linux:${STAGE} --rm=false .
	@touch linux.latest

run: linux.latest
	# This is how I invoke it through an alias
	@docker run --rm --cap-add SYS_PTRACE --cap-add SYS_ADMIN -v ${HOME}:${HOME} --hostname=tinker -it linux

clean: IMAGE=$(shell docker images -f "reference=linux:latest" --format={{.ID}})
clean:
	@if [ -n "${IMAGE}" ] ; then docker image rm -f ${IMAGE}; fi
	@rm -f linux.latest

.PHONY:
	clean refresh
