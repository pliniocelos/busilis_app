class Question {

  String _question;

  set question(String value) {
    _question = value;
  }

  String _a;
  String _b;
  String _c;
  String _correct;
  String _category;
  String _id;

  Question(this._question, this._a, this._b, this._c, this._correct,
      this._category, this._id);

  String get category => _category;

  String get correct => _correct;

  String get c => _c;

  String get b => _b;

  String get a => _a;

  String get question => _question;

  String get id => _id;

  set a(String value) {
    _a = value;
  }

  set b(String value) {
    _b = value;
  }

  set c(String value) {
    _c = value;
  }

  set correct(String value) {
    _correct = value;
  }

  set category(String value) {
    _category = value;
  }

  set id(String value) {
    _id = value;
  }
}