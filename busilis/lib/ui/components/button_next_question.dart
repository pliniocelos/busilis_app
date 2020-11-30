import 'package:flutter/material.dart';

class ButtonNextQuestion extends StatefulWidget {
  Function() _function;

  ButtonNextQuestion(Key key, this._function) : super(key: key);

  @override
  ButtonNextQuestionState createState() => ButtonNextQuestionState();
}

class ButtonNextQuestionState extends State<ButtonNextQuestion> {
  Function func;

  String text;

  @override
  Widget build(BuildContext context) {

    text = "Próximo";


    return RaisedButton(
        child: Text(
          text,
          //style: TextStyle(color: Colors.white),
        ),
        color: Color(0xff721C1E),
        disabledTextColor: Colors.white24,
        disabledColor: Color(0xff721C1E),
        highlightColor: Color(0xff721C1E),
        disabledElevation: 1,
        onPressed: func);
  }


  methodInChild(bool isLast) {

    setState(() {

      text = "sin";

      if (isLast) {
        func = null;
      } else {
        func = () {
          widget._function();
        };
      }
    });
  }
}
