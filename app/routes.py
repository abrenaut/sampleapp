import logging

from flask import request, jsonify
from werkzeug.exceptions import HTTPException

from app import app, db
from app.models import Survey, Question


@app.errorhandler(Exception)
def handle_error(e):
    logging.exception(e)
    code = 500
    if isinstance(e, HTTPException):
        code = e.code
    return jsonify(error=str(e)), code


@app.route('/survey', methods=['POST'])
def create_survey():
    req_data = request.get_json()

    new_survey = Survey(title=req_data['title'])

    db.session.add(new_survey)

    for question_data in req_data.get('questions', []):
        question = Question(survey=new_survey, text=question_data['text'])
        db.session.add(question)

    db.session.commit()

    return jsonify(new_survey.as_dict())


@app.route("/survey", methods=["GET"])
def get_survey():
    surveys = Survey.query.all()

    return jsonify([survey.as_dict() for survey in surveys])
