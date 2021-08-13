import 'package:eydev_todos/src/data/Constants.dart';
import 'package:eydev_todos/src/pages/MainPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: _constants.bgColor,
      debugShowCheckedModeBanner: false,
      title: 'eydev - Todos app',
      home: MainPage(),
    );
  }
}
