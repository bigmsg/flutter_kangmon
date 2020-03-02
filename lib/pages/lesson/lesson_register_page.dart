
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_content_register_page.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_photo_register_page.dart';



class LessonRegisterPage extends StatefulWidget {

  Lesson lesson;
  LessonRegisterPage({this.lesson});

  @override
  _LessonRegisterPageState createState() => _LessonRegisterPageState();
}

class _LessonRegisterPageState extends State<LessonRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("onTapped");
        FocusScope.of(context).unfocus();
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text('레슨등록'),),
          bottomNavigationBar: Material(
            child: Container(

              child: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 0.0),
                    insets: EdgeInsets.symmetric(horizontal:16.0)
                ),
                onTap: (index) {
                  print('--------- on tap $index --------');
                },
                tabs: <Widget>[
                  Tab(text: '레슨등록'),
                  Tab(text: '사진등록'),
                ],
              ),

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
            ),
          ),
          body: TabBarView(
            //controller: ctr,
            children: <Widget> [
              Center(child: LessonContentRegisterPage()),
              Center(child: LessonPhotoRegisterPage()),
            ]
          ),
        ),
      ),
    );
  }
}
