import 'package:url_launcher/url_launcher.dart';
import 'package:busilisapp/ui/components/checkbox_list_tile_subject.dart';
import 'package:busilisapp/ui/components/slider.dart';
import 'package:busilisapp/ui/screens/test.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  double sliderValue = 10;

  bool _chooseP = true;
  bool _chooseM = true;
  bool _chooseH = true;
  bool _chooseG = true;
  bool _chooseC = true;

  Future<void> nextScreen() async {
    if (_chooseP || _chooseM || _chooseH || _chooseG || _chooseC) {
      int qtdQuestions = sliderValue.toInt();

      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TestScreen(_chooseP, _chooseM, _chooseH,
                  _chooseG, _chooseC, qtdQuestions)));
    }
  }

  _launchURL() async {
    const url = 'https://pliniocelos.wixsite.com/site/busilis';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showAboutDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xff721C1E),
            title: Center(
                child: Text(
              "Sobre Busílis",
              style: TextStyle(color: Colors.white, fontSize: 24),
            )),
            content: //Center(child:
                Text(
              "Este app foi desenvolvido com base no livro \"Busílis - o X da questão\", escrito pelo Prof. Vasko em Aracaju (SE)",
              textAlign: TextAlign.center,
            ),
            actions: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTheme(
                            minWidth: 25.0,
                            height: 35.0,
                            child: OutlineButton(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.5),
                                child: new Text("Quero conhecer mais"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _launchURL();
                                })),
                        SizedBox(width: 8.0),
                        ButtonTheme(
                            minWidth: 25.0,
                            height: 35.0,
                            child: OutlineButton(
                                borderSide: BorderSide(color: Colors.white, width: 0.5),
                                child: new Text("Fechar"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  Navigator.pop(context);
                                }))
                      ]))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff721C1E),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
              image: AssetImage('images/app_logo.png'),
              height: 40,
            ),
            Text(
              "O \"X\" da questão",
              style: Theme.of(context).textTheme.headline6,
            ),
            ButtonTheme(
                minWidth: 60.0,
                height: 36.0,
                child: RaisedButton(
                    child: Text(
                      "Sobre",
                      style: TextStyle(fontSize: 12),
                    ),
                    color: Color(0xff721C1E),
                    disabledTextColor: Colors.white24,
                    disabledColor: Color(0xff721C1E),
                    highlightColor: Color(0xff721C1E),
                    disabledElevation: 1,
                    onPressed: showAboutDialog)),
          ],
        ),
        backgroundColor: Color(0xff5e0908),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/app_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CheckboxListTileSubject(_chooseP, "Português", (value) {
                    _chooseP = value;
                  }),
                  CheckboxListTileSubject(_chooseM, "Matemática", (value) {
                    _chooseM = value;
                  }),
                  CheckboxListTileSubject(_chooseH, "História", (value) {
                    _chooseH = value;
                  }),
                  CheckboxListTileSubject(_chooseG, "Geografia", (value) {
                    _chooseG = value;
                  }),
                  CheckboxListTileSubject(_chooseC, "Conhecimentos gerais",
                      (value) {
                    _chooseC = value;
                  }),
                  SliderBusilis(sliderValue, (value) {
                    sliderValue = value;
                  }),
                  OutlinedButton(
                    onPressed: () {
                      nextScreen();
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: BorderSide(width: 1, color: Colors.white),
                      padding: EdgeInsets.all(15.0),
                    ),
                    child: Text(
                      "Avançar",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
