# Sample app

Simple survey app

## Running locally

### Requirements

* [docker-compose](https://docs.docker.com/compose/)

### Start the service and a postgres database

```
make up
```

## Run tests

```
make test
```

## Deploy the application

### Publish the Docker image to Dockerhub

```
make release
```

### Deploy the application

```
make deploy
```

## Example requests

### Create a survey

```
curl -X POST http://localhost:5000/survey -d '{"title": "Survey 1"}' -H "Content-Type: application/json"
```

### Get the list of existing surveys

```
curl -X GET http://localhost:5000/survey
```
