import 'package:flutter/material.dart';

class SliderBusilis extends StatefulWidget {

  double sliderValue;
  Function(double) setValueSlider;

  SliderBusilis(this.sliderValue, this.setValueSlider);

  @override
  _SliderBusilisState createState() => _SliderBusilisState();
}

class _SliderBusilisState extends State<SliderBusilis> {

  String slideLabel = "10 perguntas";


  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, _setState) => Column(
              children: <Widget>[
                Slider(
                    value: widget.sliderValue,
                    min: 5,
                    max: 20,
                    divisions: 15,
                    activeColor: Colors.white,
                    inactiveColor: Colors.black12,
                    onChanged: (newValue) {

                      widget.setValueSlider(newValue);

                      setState(() {
                        widget.sliderValue = newValue;

                        slideLabel = removeDecimalZeroFormat(newValue) + " perguntas";


//                        (newValue > 1) ?
//                          slideLabel = slideLabel + " perguntas" :
//                          slideLabel = slideLabel + " pergunta";
                      });
                    }),
                Padding(padding: EdgeInsets.all(15),
                  child: Text(
                    slideLabel,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                )
              ],
            ));
  }
}
