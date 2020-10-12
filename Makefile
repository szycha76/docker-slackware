SRC	:= vbatts/slackware:current
DST	:= slack02:latest
HUB	:= szycha/slackware:current
PWD	:= $(shell /bin/pwd -P)

build:
	docker build -t $(DST) .

push: build
	docker tag $(DST) $(HUB)
	docker push $(HUB)

q:
	docker run --rm -v $(PWD):/mnt/hd -it $(SRC) /bin/bash

t:
	docker run --rm -v $(PWD):/mnt/hd -it $(DST) /bin/bash
