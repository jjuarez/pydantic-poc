#!/usr/bin/env make

.DEFAULT_GOAL  := help
.DEFAULT_SHELL := /bin/bash

DOCKER_IMAGE_NAME ?= pydantic-poc
HOST              ?= 0.0.0.0
PORT              ?= 8000
LOG_LEVEL         ?= info


.PHONY: help
help: ## Shows this pretty help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z//_-]+:.*?##/ { printf " %-20s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: lint
lint: ## lint
	@pipenv run flake8 --config .flake8 ./app ./tests

.PHONY: test
test: ## test
	@pipenv run pytest

.PHONY: docker/build
docker/build: ## Builds a Docker image for the project
	@docker image build --tag $(DOCKER_IMAGE_NAME):latest --file Dockerfile .

.PHONY: docker/start
docker/start: docker/build ## Runs the dockerized version of the app
	@docker container run --name=pydantic-poc \
		--env HOST=$(HOST) \
		--env PORT=$(PORT) \
		--env LOG_LEVEL=$(LOG_LEVEL) \
		-p$(PORT):$(PORT) \
		-d $(DOCKER_IMAGE_NAME):latest

.PHONY: docker/stop
docker/stop: ## Stops the docker container for the app
	@docker container stop pydantic-poc >/dev/null 2>&1
	@docker container rm pydantic-poc >/dev/null 2>&1

