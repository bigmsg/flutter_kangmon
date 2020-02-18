import 'package:flutter/material.dart';
import 'package:flutter_kangmon/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '강사몬',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Colors.deepOrangeAccent,
        //primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}