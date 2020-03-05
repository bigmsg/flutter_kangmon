import 'package:flutter/material.dart';



/*ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      accentColor: kUndaGreen,
      scaffoldBackgroundColor: kUndaWhite,
      cardColor: Colors.white,
      textSelectionColor: Colors.amberAccent,
      errorColor: Colors.green,
      textSelectionHandleColor: Colors.black,
      appBarTheme:_appBarTheme()
  );
}*/

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  //primarySwatch: Colors.grey,
  primarySwatch: Colors.grey,
  //primaryColor: Color.fromRGBO(18, 18, 18, 1),
  //primaryColor: Color.fromARGB(0, 18, 18, 18),
  primaryColor: Color.fromARGB(400, 24, 24, 24),
  backgroundColor: Color(0xFF000000),
  //backgroundColor: Color.fromRGBO(0,0,0,1),
  //appBarTheme:
  appBarTheme: AppBarTheme(
    elevation: 3.0,
    //color: Color.fromARGB(400, 24, 24, 24),
    //color: Color.fromRGBO(18, 18, 18, 0.5),
    color: Color.fromRGBO(50, 50, 50, 0.5),
    //color: Color.fromARGB(900, 50, 50, 50),
    textTheme: TextTheme(
      title: TextStyle(
        fontSize: 16,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    )
  ),
  scaffoldBackgroundColor: Color.fromRGBO(24, 24, 24, 1),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black54,
  buttonColor: Color.fromRGBO(50, 50, 50, 1), // 사진등록버튼
  buttonTheme: ButtonThemeData(

  ),
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
        //fontSize: 12,
        fontSize: 12,
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
  appBarTheme: AppBarTheme(
      elevation: 3.0,
      //color: Color.fromARGB(400, 24, 24, 24),
      //color: Color.fromRGBO(18, 18, 18, 0.5),
      //color: Color.fromRGBO(50, 50, 50, 0.5),
      //color: Color.fromARGB(900, 50, 50, 50),
      textTheme: TextTheme(
        title: TextStyle(
          fontSize: 16,
          color: Colors.black
        ),
      ),
      iconTheme: IconThemeData(
          //color: Colors.white
      )
  ),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.black12,
  buttonColor: Color.fromRGBO(24, 24, 24, 0.2),  // 사진등록 버튼
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