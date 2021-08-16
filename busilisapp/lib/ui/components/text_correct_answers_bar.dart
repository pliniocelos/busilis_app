import 'package:flutter/material.dart';

class TextCorrectAnswersBar extends StatefulWidget {

  String _text;

  TextCorrectAnswersBar(Key key, this._text) : super(key: key);

  @override
  TextCorrectAnswersBarState createState() => TextCorrectAnswersBarState();
}

class TextCorrectAnswersBarState extends State<TextCorrectAnswersBar> {

  @override
  Widget build(BuildContext context) {
    return Text(
      widget._text, style: TextStyle(color: Colors.white, fontSize: 14),
    );
  }

  methodInChild(String text) {
    setState(() {
      widget._text = text;
    });
  }
}

