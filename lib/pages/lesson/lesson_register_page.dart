import 'package:flutter/material.dart';


class LessonRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강사등록'),
      ),
      body: Column(
        children: <Widget>[
          Text('1.경력등록\n2.레슨등록')
        ],
      ),
    );
  }
}
