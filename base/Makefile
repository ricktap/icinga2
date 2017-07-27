NAME = ricktap/icinga2
VERSION = 0.5
RUNNER = https://gist.github.com/ricktap/4df5a564f189d0aaba357436aee38717/raw

.PHONY: build test

build:
	docker build -t $(NAME):$(VERSION) --rm image

test:
	@curl -sSL $(RUNNER) | env NAME=$(NAME) VERSION=$(VERSION) bash
