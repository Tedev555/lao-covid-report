import 'package:flutter/material.dart';
import 'package:lao_covid_tracker/pages/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lao Covid Tracker',
      theme: ThemeData(
          fontFamily: 'Noto Serif Lao',
          primaryColor: Colors.white),
      home: HomePage(),
    );
  }
}
