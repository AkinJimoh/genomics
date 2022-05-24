AMZ_LINUX_VERSION:=2
current_dir := $(shell pwd)
container_dir := /opt/app

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: archive

.PHONY: clean
clean:
	rm -rf bin 
	rm -rf config 
	rm -rf tmp/
	find ./ -type d -name '__pycache__' -delete
	find ./ -type f -name '*.pyc' -delete 

.PHONY: archive 
archive: clean
	docker build -t modules:latest .
	mkdir -p ./config/
	docker run -v $(current_dir)/config:/opt/mount --rm --entrypoint cp modules:latest /opt/app/config/exif.zip /opt/mount/exif.zip


