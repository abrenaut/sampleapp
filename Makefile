APP_NAME     = survey
CURRENT_HASH = $(shell git show -s --pretty=%H)
DOCKER_REPO  = $(DOCKERHUB_USER)

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

deploy: ## Deploy service using the Ansible playbook
	ansible-playbook -i ansible/hosts ansible/site.yml -e "dockerimagetag=$(CURRENT_HASH)"

release: build publish ## Docker release - build, tag and push the container
	@echo "Released $(DOCKER_REPO)/$(APP_NAME):$(CURRENT_HASH)"

publish: repo-login	tag ## Publish docker image to AWS-ECR
	@echo 'Publish $(CURRENT_HASH) to $(DOCKER_REPO)'
	docker push $(DOCKER_REPO)/$(APP_NAME):$(CURRENT_HASH)
	docker push $(DOCKER_REPO)/$(APP_NAME):latest

tag: ## Tags docker image with standard tags
	@echo 'Create tag $(CURRENT_HASH)'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):$(CURRENT_HASH)
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):latest

repo-login: verifyDockerhubUser ## login to Docker repository
	@echo 'Login to docker repository $(DOCKER_REPO)'
	@docker login -u $(DOCKERHUB_USER)

verifyDockerhubUser: ## Verify that the dockerhub user environment variable is defined
	$(if \
		$(findstring undefined,$(flavor DOCKERHUB_USER)), \
		$(error 'DOCKERHUB_USER environment variable must be defined'))

help: ## Show available make targets.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
