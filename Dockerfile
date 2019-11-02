FROM python:3.7-alpine

WORKDIR /app

ENV FLASK_APP survey.py
ENV FLASK_RUN_HOST 0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers postgresql-dev gcc

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

CMD ["flask", "run"]
