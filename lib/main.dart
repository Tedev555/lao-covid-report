import 'package:flutter/material.dart';
import 'package:lao_covid_tracker/pages/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      title: 'Lao Covid Tracker',
      theme: ThemeData(
          fontFamily: 'Noto Serif Lao',
          primaryColor: Color.fromRGBO(53, 43, 89, 1),
          accentColor: Color.fromRGBO(35, 103, 247, 1)),
      home: HomePage(),
    );
  }
}
