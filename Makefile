include .env

default: up

install:
	make build
build:
	docker-compose up -d --build --force-recreate
up:
	docker-compose up -d --remove-orphans
stop:
	docker-compose stop
rm:
	docker-compose rm

in:
	docker-compose exec ${PROJ} bash
indb:
	docker-compose exec ${PROJ}-db bash

prune:
	docker builder prune
