APP_NAME     = survey

up: build migrate ## Run the app out of a docker image on port 5000
	docker-compose run -p 5000:5000 app

test: ## Run the test suite for this app
	docker-compose run app pytest

generate-migration:
	docker-compose run app flask db migrate

migrate: build ## Run database migrations.
	docker-compose run --rm app flask db upgrade

build: ## Build the docker container
	docker build -t $(APP_NAME) .

help: ## Show available make targets.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
