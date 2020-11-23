import 'package:fake_reviews/components/bottom_button.dart';
import 'package:fake_reviews/providers/items_provider.dart';
import 'package:fake_reviews/providers/log_provider.dart';
import 'package:fake_reviews/screens/6_start_experiment.dart';
import 'package:fake_reviews/screens/3_instruction_screen.dart';
import 'package:fake_reviews/utils/questions.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:provider/provider.dart';
import 'package:numberpicker/numberpicker.dart';

import '4_test_description_screen.dart';

class SurveyScreen extends StatefulWidget {
  SurveyScreen({Key key}) : super(key: key);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  int numberOfQuestions = questions.length;
  List<List<String>> _answers = List.generate(questions.length, (i) => List.empty(growable: true));
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  void addToAnswers(int index, String value) {
    setState(() {
      _answers[index].add(value);
    });
  }

  void removeFromAnswers(int index, String value) {
    setState(() {
      _answers[index].remove(value);
    });
  }

  void overwriteAnswer(int index, String value) {
    if (_answers[index].isEmpty)
      addToAnswers(index, value);
    else
      setState(() {
        _answers[index][0] = value;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Benvenuto'),
        leading: Container(width: 0),
      ),
      body: ScrollablePositionedList.builder(
        itemCount: numberOfQuestions + 2,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemBuilder: (context, index) {
          if (index == 0)
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Text(
                'Prima di cominciare ti chiediamo di rispondere ad alcune domande in modo da avere qualche informazione sul campione che ha partecipato all\'esperimento',
                style: Theme.of(context).textTheme.bodyText1,
                softWrap: true,
              ),
            );
          else if (index == numberOfQuestions + 1)
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: BottomButton(
                text: 'Avanti',
                onPressed: () {
                  final unfilledQuestion = _answers.indexWhere(
                          (element) => element.isEmpty);
                  if (unfilledQuestion != -1) {
                    itemScrollController.scrollTo(
                        index: unfilledQuestion + 1, duration: Duration(milliseconds: 500));
                  } else {
                    context.read<LogProvider>().sendSurveyAnswers(_answers);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstructionScreen()),
                    );
                  }
                },
              ),
            );

          int indexOfQuestion = index - 1;

          final Question item = questions[indexOfQuestion];

          var answersWidget;
          if(item.numericQuestion) {
            _answers[indexOfQuestion].add('23');
            answersWidget =[NumberPicker.integer(
                initialValue: int.tryParse(_answers[indexOfQuestion][0]),
                minValue: 1,
                maxValue: 100,
                onChanged: (number) {
                  overwriteAnswer(indexOfQuestion, number.toString());
                })];
          }
          else if (item.allowMultipleAnswers == false) {
            answersWidget = item.possibleAnswers.map((answer) {
              return RadioListTile<String>(
                title: Text(
                  answer,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                dense: true,
                value: answer,
                groupValue: _answers[indexOfQuestion].isNotEmpty ? _answers[indexOfQuestion][0] : '',
                onChanged: (String value) {
                  overwriteAnswer(indexOfQuestion, value);

                  if(indexOfQuestion != questions.length -1)
                    Future.delayed(const Duration(milliseconds: 200)).then((value) =>
                      itemScrollController.scrollTo(
                          index: index + 1, duration: Duration(milliseconds: 200)));
                },
              );
            });
          } else {
            answersWidget = item.possibleAnswers.map((answer) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  answer,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                dense: true,
                value: _answers[indexOfQuestion].contains(answer),
                onChanged: (bool value) {
                  if (value)
                    addToAnswers(indexOfQuestion, answer);
                  else
                    removeFromAnswers(indexOfQuestion, answer);
                },
              );
            });
          }
          return Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 10, left: 24, right: 24),
                    child: Text(
                      item.text,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  ...answersWidget,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
