SRC	:= vbatts/slackware:current
DST	:= slack02:latest
MKI	:= slack02:mkimage
HUB	:= szycha/slackware:current
PWD	:= $(shell /bin/pwd -P)
MKIMG	:= /c/Users/e-mnsi/GIT/github.com/szycha76/slackware-container
IMGOUT	:= /c/Users/e-mnsi/slackware-container

build:
	docker build -t $(DST) .

push: build
	docker tag $(DST) $(HUB)
	docker push $(HUB)

q:
	docker run --rm -v $(PWD):/mnt/hd -it $(SRC) /bin/bash

t:
	docker run --rm -v $(PWD):/mnt/hd -it $(DST) /bin/bash

mt:
	docker run --rm -v $(MKIMG):/mnt/hd -v $(IMGOUT):/tmp -it $(MKI) /bin/bash

mkimage: build
	docker build -t $(MKI) $@
	mkdir -pv $(IMGOUT)
	# This won't work since mount --bind is apparently not supported on docker [on Windows?]
	docker run --rm -v $(MKIMG):/mnt/hd -v $(IMGOUT):/tmp -it $(MKI) /mnt/hd/mkimage-slackware.sh



.PHONY: mkimage
