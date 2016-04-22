IMAGETAG := zlim/bcc

.PHONY: build
build:
	docker build -t $(IMAGETAG) .

.PHONY: push
push:
	docker push $(IMAGETAG)

UNAMER := $(shell uname -r)
HOST_DIRS := /lib/modules/$(UNAMER) /usr/src/linux-headers-$(UNAMER)
HOST_DIRS += /usr/src/linux-headers-$(subst -generic,,$(UNAMER))
HOST_DIRS += /etc/localtime
DOCKER_VOLUMES := $(join $(HOST_DIRS),$(addprefix :,$(HOST_DIRS)))
DOCKER_VOLUMES := $(addsuffix :ro,$(DOCKER_VOLUMES))
DOCKER_VOLUMES := $(addprefix -v ,$(DOCKER_VOLUMES))

#DOCKER_CAP_ADD := SYS_ADMIN
#DOCKER_CAPS := $(addprefix --cap-add ,$(DOCKER_CAP_ADD))
DOCKER_CAPS := --privileged

.PHONY: run
run:
	docker run -it --rm $(DOCKER_CAPS) $(DOCKER_VOLUMES) --workdir /usr/share/bcc/ $(IMAGETAG)

IMAGETAGTRUSTY := $(IMAGETAG):trusty

.PHONY: build.trusty
build.trusty:
	docker build -f Dockerfile.trusty -t $(IMAGETAGTRUSTY) .

.PHONY: push.trusty
push.trusty:
	docker push $(IMAGETAGTRUSTY)

.PHONY: run.trusty
run.trusty:
	docker run -it --rm $(DOCKER_CAPS) $(DOCKER_VOLUMES) --workdir /usr/share/bcc/ $(IMAGETAGTRUSTY)

