# You may want to change these two:
USERPROFILE	:= /c/Users/e-mnsi
HOME	:= /home/szycha

# And probably some of these:
SL	:= slack02
DST	:= $(SL):latest
MKI	:= $(SL):mkimage
PYTHON	:= $(SL):python3
HUB	:= szycha/slackware:current
MKIMG	:= $(USERPROFILE)/GIT/github.com/szycha76/slackware-container
IMGOUT	:= $(USERPROFILE)/slackware-container
PWD	:= $(shell /bin/pwd -P)
SRC	:= vbatts/slackware:current

# Type 'make' to build basic image

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

pt: python
	docker run --rm -v $(USERPROFILE):$(HOME) -v /c:/mnt/host/c -it $(PYTHON) /bin/bash

python: build
	docker build -t $(PYTHON) $@


.PHONY: mkimage python
