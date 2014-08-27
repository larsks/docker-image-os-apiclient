BRANCH=$(shell git symbolic-ref --short HEAD)
TAG=$(subst master,latest,$(BRANCH))
IMAGE=$(shell basename $(shell pwd))

all:
	docker build -t larsks/$(IMAGE):$(TAG) .

