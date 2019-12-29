# Build a linux docker image

all: linux.latest

linux.latest: SOURCE=$(subst from ,,$(shell grep -E "^FROM" Dockerfile|tr 'A-Z' 'a-z'))
linux.latest: bashrc Makefile Dockerfile
	@echo Building linux based on ${SOURCE}
	@docker pull ${SOURCE}
	@docker build -q --tag=linux:latest --rm .
	@touch linux.latest

run: linux.latest
	@docker run --rm -v ~/:/home/tinker/$(shell hostname) -it linux

clean: IMAGE=$(shell docker images -f "reference=linux:latest" --format={{.ID}})
clean:
	@if [ -n "${IMAGE}" ] ; then docker image rm -f ${IMAGE}; fi
	@rm -f linux.latest

.PHONY:
	clean
