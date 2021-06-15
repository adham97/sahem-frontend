import 'package:flutter/material.dart';

import '../repository/settings_repository.dart';

import '../models/question.dart';

class QuestionBubble extends StatelessWidget {
  final List<Question> questions;
  final Function(String) onTapQuestion;

  const QuestionBubble({Key key, this.questions, this.onTapQuestion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (questions.length.toDouble() * 50),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTapQuestion(questions.elementAt(index).id),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor.withOpacity(0.9),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Theme.of(context).hintColor.withOpacity(0.2),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                setting.value.mobileLanguage.value == Locale('en', '')
                                    ? questions.elementAt(index).questionEn
                                    : questions.elementAt(index).questionAr,
                                style: Theme.of(context).textTheme.bodyText1
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          );
        },
      )
    );
  }
}