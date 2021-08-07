import 'package:busilis/ui/screens/choose_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  // We need to call this manually,
  // because we're going to call setPreferredOrientations()
  // before the runApp() call
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIOverlays([]);

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(
    //home: ChooseScreen(),
    home: ChooseScreen(),

    debugShowCheckedModeBanner: false,

    theme: ThemeData(

      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.white,

      // Define the default font family.
      fontFamily: 'Roboto',

      toggleableActiveColor: Colors.transparent,

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 22.0, color: Colors.white),
        headline3: TextStyle(fontSize: 20.0, color: Colors.white),
        headline4: TextStyle(fontSize: 18.0, color: Colors.white),
        headline5: TextStyle(fontSize: 16.0, color: Colors.white),
        headline6: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  )));
}

