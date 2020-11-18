import 'package:fake_reviews/utils/questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// This is the stateful widget that the main application instantiates.
class QuestionScreen extends StatefulWidget {
  int index;

  QuestionScreen({Key key, index = 0}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _QuestionScreenState extends State<QuestionScreen> {
  List<String> answers = [];

  @override
  Widget build(BuildContext context) {
    Question question = questions[widget.index];

    List<dynamic> possibleAnswers;

    if(question.allowMultipleAnswers) {
      possibleAnswers = question.possibleAnswers.map((answer) => CheckboxListTile(
        title: Text(answer),
        value: false,
        onChanged: (bool value) {
          setState(() {
            if(value)
              answers.add(answer);
            else
              answers.remove(answer);
          });
        },
      )).toList();
      
    } else {
      possibleAnswers = question.possibleAnswers.map((answer) => RadioListTile<String>(
            title: Text(answer),
            value: answer,
            groupValue: answers.first,
            onChanged: (String value) {
              setState(() {
                answers = [value];
              });
            },
          )).toList();
    }
    return Card(child: Column(children: possibleAnswers));
  }
}
