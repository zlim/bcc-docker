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

.PHONY: run
run:
	docker run -it --rm $(DOCKER_VOLUMES) --workdir /usr/share/bcc/ $(IMAGETAG)

