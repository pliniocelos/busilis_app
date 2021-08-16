import 'package:flutter/material.dart';

class CheckboxListTileSubject extends StatefulWidget {

  bool _choosed;
  String _label;

  Function(bool) setValueChecked;

  CheckboxListTileSubject(this._choosed, this._label, this.setValueChecked);

  @override
  _CheckboxListTileSubjectState createState() => _CheckboxListTileSubjectState();
}

class _CheckboxListTileSubjectState extends State<CheckboxListTileSubject> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, _setState) => CheckboxListTile(
        title: Text(
          widget._label,
          style: Theme.of(context).textTheme.headline3
        ),
        value: widget._choosed,
        onChanged: (newValue) {

          widget.setValueChecked(newValue);

          _setState(() => {
            widget._choosed = newValue,
          });
        },
      ),
    );
  }
}
