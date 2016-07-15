ACCOUNT = ocramz
PROJECT = petsc-docker
TAG = $(ACCOUNT)/$(PROJECT)

.DEFAULT_GOAL := help

help:
	@echo "Use \`make <target>\` where <target> is one of"
	@echo "  help     display this help message"
	@echo "  rbuild   build remotely (on Docker hub)"
	@echo "  build    build the docker image"
	@echo "  pull     fetch precompiled image from Docker hub"
	@echo "  rebuild  '', ignoring previous builds"
	@echo "  login    login to your docker account"
	@echo "  push     push the image to the docker registry"
	@echo "  run      run the image"

rbuild:
	curl -H "Content-Type: application/json" --data '{"build": true}' -X POST https://registry.hub.docker.com/u/ocramz/petsc-docker/trigger/ecc7cfd9-7d05-40dd-b4b1-34be78d7a696/


build:
	docker build -t $(TAG) .

rebuild:
	docker build -no-cache -t $(TAG) .

pull:
	docker pull $(TAG)

login:
	docker login -u $(ACCOUNT)

push: build login
	docker push $(TAG)

run: 
	docker run -it --rm $(TAG) /bin/bash
