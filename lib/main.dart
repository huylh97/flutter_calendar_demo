// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'views/home/home_screen.dart';

void main() {
  return runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calendar App",
      home: HomeScreen(),
    );
  }
}
