import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강사방'),
      ),
      body: Center(
        child: Text('강사방 공사중...', style: TextStyle(
            fontSize: 40
        ),),
      ),
    );
  }
}

