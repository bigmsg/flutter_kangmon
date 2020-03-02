import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      //length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: Text('강사방'),
            bottom: TabBar(
              //controller: ctr,
              tabs: <Tab>[
                Tab(text: '프로필'),
                Tab(text: '레슨등록'),
                Tab(text: '사진등록'),
              ],
            ),

        ),
        bottomNavigationBar: Material(
          //color: Colors.grey,
          child: Container(
          decoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
            color: Color.fromARGB(0, 24, 24, 24),
            border: Border(
                top: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
          ),
          //height: 65,
          //color: Color.fromARGB(100, 24, 24, 24),
            child: TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 0.0),
                  insets: EdgeInsets.symmetric(horizontal:16.0)
              ),
              tabs: <Widget>[
                Tab(child: Text('레슨목록')),
                Tab(child: Text('레슨등록')),
                Tab(child: Text('통계보기')),
              ],
            )
          )
        ),
        body: TabBarView(
          //controller: ctr,
          children: <Widget> [
            Center(child: Text('레슨목록')),
            Center(child: Text('레슨등록')),
            Center(child: Text('통계보기')),
          ]
        ),
      )
    );
  }
}

