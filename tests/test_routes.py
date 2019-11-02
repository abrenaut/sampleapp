import json
import os
import tempfile

import pytest

from app import app, db
from app.models import Survey


@pytest.fixture
def client():
    db_fd, db_filepath = tempfile.mkstemp()
    app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{db_filepath}'
    app.config['TESTING'] = True

    with app.test_client() as client:
        with app.app_context():
            db.create_all()
        yield client

    os.close(db_fd)
    os.unlink(db_filepath)


def test_create_survey(client):
    client.post('/survey',
                data=json.dumps(
                    {
                        'title': 'bar',
                        'questions': [
                            {'text': 'Question 1'},
                            {'text': 'Question 2'},
                        ],
                    }
                ),
                content_type='application/json')
    surveys = Survey.query.all()
    assert len(surveys) == 1
    assert len(surveys[0].questions) == 2
