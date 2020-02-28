import 'package:flutter/material.dart';


final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  backgroundColor: Color(0xFF000000),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black54,
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 10,
    ),
    title: TextStyle(
        fontSize: 10
    ),
    subtitle: TextStyle(
        fontSize: 10
    ),
    caption: TextStyle(
      fontSize: 10,
    ),
    button: TextStyle(
      color: Colors.pink,
      fontSize: 12,
    ),

    body1: TextStyle( // 목록, 대부분의 글짜 크기
        fontSize: 12
    ),

    body2: TextStyle(
        fontSize: 30
    ),
    display1: TextStyle(
      fontSize: 10,
    ),
    display2: TextStyle(
      fontSize: 10,
    ),
    display3: TextStyle(
      fontSize: 20,
    ),
    display4: TextStyle(
      fontSize: 20,
    ),

    subhead: TextStyle( // TextField
      fontSize: 14,
    ),

    overline: TextStyle(
      fontSize: 10,
    ),
  ),
);


final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  backgroundColor: Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.black12,
  textTheme: TextTheme(
    headline: TextStyle(
      fontSize: 10,
    ),
    title: TextStyle(
        fontSize: 10
    ),
    subtitle: TextStyle(
        fontSize: 10
    ),
    caption: TextStyle(
      fontSize: 10,
    ),
    button: TextStyle(
      color: Colors.pink,
      fontSize: 12,
    ),

    body1: TextStyle( // 목록, 대부분의 글짜 크기
        fontSize: 12
    ),

    body2: TextStyle(
        fontSize: 30
    ),
    display1: TextStyle(
      fontSize: 10,
    ),
    display2: TextStyle(
      fontSize: 10,
    ),
    display3: TextStyle(
      fontSize: 20,
    ),
    display4: TextStyle(
      fontSize: 20,
    ),

    subhead: TextStyle( // TextField
      fontSize: 14,
    ),

    overline: TextStyle(
      fontSize: 10,
    ),
  ),
);