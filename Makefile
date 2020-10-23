# You may want to change these two:
USERPROFILE	:= /c/Users/e-mnsi
HOME	:= /home/szycha

# And probably some of these:
SL	:= slackware
DST	:= $(SL):current
MKI	:= $(SL)-mkimage:current
PYTHON	:= $(SL)-python:current
JUPYTER	:= $(SL)-jupyter:current
PFX	:= szycha
MKIMG	:= $(USERPROFILE)/GIT/github.com/szycha76/slackware-container
IMGOUT	:= $(USERPROFILE)/slackware-container
PWD	:= $(shell /bin/pwd -P)
SRC	:= vbatts/slackware:current

DOCKER	:= docker
BUILD	:= $(DOCKER) build --no-cache
RUN	:= $(DOCKER) run
TAG	:= $(DOCKER) tag
PUSH	:= $(DOCKER) push

# Type 'make' to build basic image

build:
	$(call labelroot)
	$(BUILD) -t $(DST) -t $(PFX)/$(DST) .

push:
	$(PUSH) $(PFX)/$(SL):current
	$(PUSH) $(PFX)/$(PYTHON)
	$(PUSH) $(PFX)/$(JUPYTER)

q:
	$(RUN) --rm -v $(PWD):/mnt/hd -it $(SRC) /bin/bash

t:
	$(RUN) --rm -v $(PWD):/mnt/hd -it $(DST) /bin/bash

mt:
	$(RUN) --rm -v $(MKIMG):/mnt/hd -v $(IMGOUT):/tmp -it $(MKI) /bin/bash

mkimage: build
	$(call labelroot)
	$(BUILD) -t $(MKI) $@
	mkdir -pv $(IMGOUT)
	# This won't work since mount --bind is apparently not supported on docker [on Windows?]
	$(RUN) --rm -v $(MKIMG):/mnt/hd -v $(IMGOUT):/tmp -it $(MKI) /mnt/hd/mkimage-slackware.sh

pt: python
	$(RUN) --rm -v $(USERPROFILE):$(HOME) -v /c:/mnt/host/c -it $(PYTHON) /bin/bash

python_here: python
	if [[ -z "$(WD)" ]]; then exit 1; fi
	$(RUN) --rm -v $(USERPROFILE):$(HOME) -v /c:/mnt/host/c -v $(WD):/mnt/hd -it $(PYTHON) /bin/bash

python: build
	$(call labelroot)
	$(BUILD) -t $(PYTHON) -t $(PFX)/$(PYTHON) $@

jupyter: python
	$(call labelroot)
	$(BUILD) -t $(JUPYTER) -t $(PFX)/$(JUPYTER) $@

ju:
	$(RUN) --rm -v $(USERPROFILE):$(HOME) -v /c:/mnt/host/c -v $(WD):/mnt/hd -p 8888:8888 -it $(JUPYTER) /bin/bash

define labelroot
$(shell echo $@ > $@/.buildtag || echo $@ > .buildtag)
endef

.PHONY: mkimage python jupyter
