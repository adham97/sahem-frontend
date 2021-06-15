class Question{
  String id;
  String questionEn;
  String questionAr;

  Question();

  Question.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['question_id'];
      questionEn = jsonMap['question_en'];
      questionAr = jsonMap['question_ar'];
    } catch (e) {
      print(e);
    }
  }
}