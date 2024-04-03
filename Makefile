# Copyright 2021-2022, Offchain Labs, Inc.
# For license information, see https://github.com/nitro/blob/master/LICENSE

# Docker builds mess up file timestamps. Then again, in docker builds we never
# have to update an existing file. So - for docker, convert all dependencies
# to order-only dependencies (timestamps ignored).
# WARNING: when using this trick, you cannot use the $< automatic variable
DOCKER_REPOSITORY := quay.io/amis
DOCKER_IMAGE := $(DOCKER_REPOSITORY)/indexer-subnet-evm
ifeq ($(DOCKER_IMAGE_TAG),)
DOCKER_IMAGE_TAG := $(shell git rev-parse --short HEAD 2> /dev/null)
endif

docker:
	@docker build -f ./Dockerfile -t $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) --build-arg AVALANCHE_VERSION=v1.11.3 .
	@docker tag $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG) $(DOCKER_IMAGE):latest

docker.push:
	@docker push $(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG)
	@docker push $(DOCKER_IMAGE):latest
