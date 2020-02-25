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


final currentUserBloc = CurrentUserBloc();


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '강사몬',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        //primaryColor: Colors.deepOrangeAccent,
        primaryColor: Colors.deepOrangeAccent,
        //primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
