import 'package:busilisapp/ui/screens/choose_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void nextScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff721C1E),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/app_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Image(
                        image: AssetImage('images/app_logo.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text("Teste seus conhecimentos!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3),
                    ),
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
                        "Começar",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
