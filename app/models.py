from app import db


class Survey(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), nullable=False)
    questions = db.relationship('Question',
                                backref=db.backref('survey', lazy='joined'),
                                lazy='select')

    def as_dict(self):
        return {c.name: getattr(self, c.name) for c in self.__table__.columns}


class Question(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String(2500), nullable=False)
    survey_id = db.Column(db.Integer, db.ForeignKey('survey.id'),
                          nullable=False)
