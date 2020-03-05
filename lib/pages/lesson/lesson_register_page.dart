
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_content_register_page.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_photo_register_page.dart';
import 'package:flutter_kangmon/data/globals.dart' as globals;


class LessonRegisterPage extends StatefulWidget {

  Lesson lesson;
  int tabIndex;

  LessonRegisterPage({this.lesson, this.tabIndex});

  @override
  _LessonRegisterPageState createState() => _LessonRegisterPageState();
}

class _LessonRegisterPageState extends State<LessonRegisterPage> with SingleTickerProviderStateMixin {

  TabController _tabController;


  @override
  void initState() {
    super.initState();
    //_tabController = new TabController(length: 3, vsync: this);
    _tabController = TabController(vsync: this, length: 2, initialIndex: widget.tabIndex);
    globals.registerLessonTabController = _tabController;
    super.initState();

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*Future.delayed(Duration(milliseconds: 100)).then((_) {
      print('hello');
      _tabController.animateTo(widget.tabIndex);
    });*/

    return GestureDetector(
      onTap: () {
        print("onTapped");
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('레슨등록'),),
        bottomNavigationBar: Material(
          child: Container(

            child: TabBar(
              controller: globals.registerLessonTabController,
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
          controller: globals.registerLessonTabController,
          children: <Widget> [
            Center(child: LessonContentRegisterPage()),
            Center(child: LessonPhotoRegisterPage()),
          ]
        ),
      ),
    );
  }
}
