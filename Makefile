# Build a linux docker image

USER := $(shell whoami)
HOME := $(shell realpath ~)

all: linux.latest

linux.latest: SOURCE=$(subst from ,,$(shell grep -E "^FROM" Dockerfile|tr 'A-Z' 'a-z'))
linux.latest: bashrc Makefile Dockerfile
	@echo Building linux based on ${SOURCE}
	@docker pull ${SOURCE}
	@docker build -q --build-arg HOME=${HOME} --build-arg USER=${USER} --tag=linux:latest --rm .
	@touch linux.latest

run: linux.latest
	# This is how I invoke it through an alias
	@docker run --rm --cap-add SYS_PTRACE --cap-add SYS_ADMIN -v ${HOME}:${HOME} --hostname=tinker -it linux

clean: IMAGE=$(shell docker images -f "reference=linux:latest" --format={{.ID}})
clean:
	@if [ -n "${IMAGE}" ] ; then docker image rm -f ${IMAGE}; fi
	@rm -f linux.latest

.PHONY:
	clean
