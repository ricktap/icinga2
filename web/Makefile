NAME = ricktap/icinga2-web
VERSION = 0.5
RUNNER = https://gist.github.com/ricktap/4df5a564f189d0aaba357436aee38717/raw

.PHONY: build run test rm logs

build:
	docker build -t $(NAME):$(VERSION) --rm image

run: rm
	docker run --rm -d -p 8080:80 -p 8443:443 --name $(shell basename $(NAME)) $(NAME):$(VERSION)

test:
	@curl -sSL $(RUNNER) | env NAME=$(NAME) VERSION=$(VERSION) bash

rm:
	@docker rm -f $(shell basename $(NAME)) || true

logs:
	docker logs $(shell basename $(NAME))
