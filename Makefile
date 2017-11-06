build:
	@docker run --rm -it \
		-v $$(pwd):/app \
		-v ~/.composer:/tmp \
		composer install

lint: ## Check the validness of markdown/php
lint: lint-md lint-php

lint-md: ## Check the validness of markdown
	@echo 'linting markdown...'
	@docker run --rm -v $$(pwd):/data:cached gouvinb/docker-markdownlint -v *.md standards/*.md

lint-php: ## Check the validness of php
	@echo 'linting php...'
	@mkdir -p cache
	@docker run --rm -it -v $$(pwd):/srv:cached graze/php-alpine:test vendor/bin/phpcs \
		-p --warning-severity=0 --cache=cache/phpcs --parallel=10 \
		PHP/ examples/