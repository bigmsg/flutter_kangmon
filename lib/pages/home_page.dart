import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/models/lesson_photos_provider.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_list_page.dart';
import 'package:flutter_kangmon/pages/member/login_page.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_list_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_home.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_profile_register_page.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'admin/admin_home.dart';
import 'lesson/lesson_detail_page.dart';
import 'lesson/test.dart';
import 'member/mypage_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  //TabController ctr;
  /*@override void initState() {
    super.initState();
    ctr = new TabController(vsync: this, length: 3);
  }

  @override void dispose() {
    ctr.dispose();
    super.dispose();
  }*/

  @override
  initState() {
    super.initState();
    initialApp();
  }



  @override
  Widget build(BuildContext context) {

    var currentUser = Provider.of<CurrentUser>(context);
    var photos = Provider.of<LessonPhotos>(context);
    print('home page(mb_nick): ${currentUser.data.mb_group}');

    bool isAdmin = ['super', 'teacher'].contains(currentUser.data.mb_group);
    bool isSuper = ['super'].contains(currentUser.data.mb_group);


    //return LessonListPage();
    return DefaultTabController(
        length: isAdmin ? 4: 3,
        //length: 4,
        child: Scaffold(
          bottomNavigationBar: Material(
            //color: Colors.grey,
            child: Container(
              //height: 65,
              child: TabBar(
                //controller: ctr,
                tabs: isAdmin ? _buildTabBar4(isSuper) : _buildTabBar3(),
              ),

              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -1),
                      blurRadius: 6.0
                  )
                ]
              ),
            ),
          ),
          body: TabBarView(
            //controller: ctr,
            children: isAdmin ? _buildPage4(isSuper) : _buildPage3(),
          ),
        ),
      );
    }



  _buildTabBar4(bool isSuper) {

    return <Widget>[
      Tab(child: Text('레슨', style: TextStyle(
        fontSize: 12
      ),),),

      isSuper ? Tab(child: FlatButton(
        child: Text('영자방',),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AdminHome()));
        },
      ),)

      : Tab(child: FlatButton(
        child: Text('강사'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => TeacherHome()));
        },
      ),),

      Tab(child: Text('게시판'),),
      Tab(child: Text('MY'),),
    ];

  }

  _buildTabBar3() {
    return <Widget>[
      Tab(child: Text('레슨', style: TextStyle(
          fontSize: 12
      ),),),
      Tab(child: Text('게시판', style: TextStyle(
        fontSize: 12
      ),),),
      Tab(child: Text('MY', style: TextStyle(
          fontSize: 12
      ),),),
    ];

  }

  _buildPage4(bool isSuper) {
    return <Widget>[
      LessonListPage(),
      isSuper ? AdminHome() : TeacherHome(),
      BbsListPage(),
      MyPage(),

    ];

  }

  _buildPage3() {
    return <Widget>[
      LessonListPage(),
      BbsListPage(),
      MyPage(),

    ];

  }

}


