import 'package:flutter/material.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_register_page.dart';

class PortfolioRegisterPage extends StatefulWidget {
  @override
  _PortfolioRegisterPageState createState() => _PortfolioRegisterPageState();
}

class _PortfolioRegisterPageState extends State<PortfolioRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강사 경력및 자격증등록'),
      ),
      body: Column(
        children: <Widget>[
          Text('경력및 자격증 등록'),
          FlatButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonRegisterPage())),
            child: Text('레슨등록'),
          ),
        ]
      ),
    );
  }
}
