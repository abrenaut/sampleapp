import logging
import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

logging.basicConfig(level=logging.INFO)

app = Flask(__name__)
default_connection_url = 'postgres://postgres:postgres@localhost:5432/survey'
connection_url = os.getenv('SQLALCHEMY_DATABASE_URI', default_connection_url)
app.config['SQLALCHEMY_DATABASE_URI'] = connection_url
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
migrate = Migrate(app, db)

from app import routes, models
