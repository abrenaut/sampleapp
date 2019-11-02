# Sample app

Simple survey app

## Example requests

### Create a survey

```
curl -X POST http://localhost:5000/survey -d '{"title": "Survey 1"}' -H "Content-Type: application/json"
```

### Get the list of existing surveys

```
curl -X GET http://localhost:5000/survey
```
