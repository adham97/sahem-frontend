class Answer {
  String id;
  String answerEn;
  String answerAr;

  Answer();

  Answer.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['answer_id'];
      answerEn = jsonMap['answer_en'];
      answerAr = jsonMap['answer_ar'];
    } catch (e) {
      print(e);
    }
  }
}