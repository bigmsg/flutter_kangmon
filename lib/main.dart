import 'package:flutter/material.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_kangmon/help/common.dart';

//void main() => runApp(MyApp());
void main() {
  //SharedPreferences.setMockInitialValues({}); // 꼭 해줘야 SharedPreferences 사용가능함
  //prefs.setMockInitialValues(values) // values type is Map<String, dynamic>
  return runApp(MyApp());
}





class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '강사몬',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Color.fromRGBO(245, 171, 161, 1), // 진한 살색
        /*textTheme: TextTheme(
          button: TextStyle(
            color: Colors.pink,
            fontSize: 2,
          ),
        ),*/

        //buttonColor: Colors.blue,
        //primaryColor: Colors.deepOrangeAccent,
        //primaryColor: Colors.deepOrangeAccent,
        //primaryColor: Color.fromRGBO(207, 227, 255, 1), // 하늘색
        //primaryColor: Color.fromRGBO(237, 56, 145, 1), // 핑크
        //primaryColor: Color.fromRGBO(24, 248, 222, 1), // 밝은 녹색
        //primaryColor: Color.fromRGBO(255, 230, 200, 1), // 밝은 살색
        //primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
