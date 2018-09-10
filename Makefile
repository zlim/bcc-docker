REPO := zlim/bcc
TAGS := trusty xenial bionic

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

define ADD_TARGET
build: build.${1}
.PHONY: build.${1}
build.${1}:
	docker build -t $(REPO):${1} -f Dockerfile.${1} .

push: push.${1}
.PHONY: push.${1}
push.${1}:
	docker push $(REPO):${1}

.PHONY: run.${1}
run.${1}:
	docker run -it --rm $(DOCKER_CAPS) $(DOCKER_VOLUMES) --workdir /usr/share/bcc/ $(REPO):${1}
endef #ADD_TARGET

.PHONY: build push
$(foreach TAG,$(TAGS),\
	$(eval $(call ADD_TARGET,${TAG})))

.PHONY: run
run:
	echo "Run targets are: $(addprefix run.,$(TAGS))"

