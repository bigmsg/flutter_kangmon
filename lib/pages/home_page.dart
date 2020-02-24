import 'package:flutter/material.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return LessonListPage();
  }

}


