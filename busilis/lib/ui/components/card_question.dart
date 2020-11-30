import 'package:busilis/models/question.dart';
import 'package:busilis/ui/screens/test.dart';
import 'package:flutter/material.dart';

class CardQuestion extends StatefulWidget {

  String _number;

  Function(bool) _itsCorrect;

  CardQuestion(this._number, this._itsCorrect);

  @override
  CardQuestionState createState() => CardQuestionState();
}

class CardQuestionState extends State<CardQuestion> {

  String selectedRadioTile = '';
  String msg = '';
  int answer = 0; // it has 3 states: 0 - to hide box, 1 - shows box correct, 2 - shows box wrong
  bool locked = false;

  getRadioListTile(String proposition, String letter, Question q) {
    if (!locked) {
      return RadioListTile(
        activeColor: Colors.white,
        title: Text(proposition),
        value: letter,
        groupValue: selectedRadioTile,
        onChanged: (value) {
          selectedRadioTile = value;
          setResponseAnswer(letter, q);
          locked = true;
        },
      );
    } else {
      return RadioListTile(
        activeColor: Colors.white,
        title: Text(proposition),
        value: letter,
        groupValue: selectedRadioTile,
        onChanged: null
      );
    }
  }

  coloredBoxAnswer(String correctOrWrong, MaterialColor color) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      color: color,
      child: Text(
        correctOrWrong,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  setResponseAnswer(String res, Question q) {
    res == q.correct ? answer = 1 : answer = 2;

    if (answer == 1) {
      widget._itsCorrect(true);
    } else if (answer == 2) {
      widget._itsCorrect(false);
    }

    setState(() {
      if (answer == 2) {

        String correctProposition;

        switch(q.correct) {
          case "a":
            correctProposition = q.a;
            break;
          case "b":
            correctProposition = q.b;
            break;
          case "c":
            correctProposition = q.c;
            break;
          default: correctProposition = "";
        }

        msg = "O correto é: $correctProposition";

      }
    });
  }

  showColoredBox(int res) {
    switch (res) {
      case 0:
        return Container();
      case 1:
        return coloredBoxAnswer("CORRETO", Colors.green);
      case 2:
        return coloredBoxAnswer("ERRADO", Colors.red);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {

    final Question _q = QuestionProvider.of(context).question;

    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white)
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
                  width: 50,
                  child: Text(
                    widget._number,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: Text(
                    _q.question,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.transparent,
            ),
            getRadioListTile(_q.a, "a", _q),
            getRadioListTile(_q.b, "b", _q),
            getRadioListTile(_q.c, "c", _q),
            Divider(
              color: Colors.transparent,
            ),

            showColoredBox(answer),
            Divider(
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(

                  child: Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}


