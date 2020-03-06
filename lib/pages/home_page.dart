import 'package:flutter/material.dart';
import 'package:flutter_kangmon/chat/chat_list_page.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/models/lesson_photos_provider.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_list_page.dart';
import 'package:flutter_kangmon/pages/member/login_page.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_list_page.dart';
import 'package:flutter_kangmon/pages/teacher/my_lesson_list_page.dart';
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
        length: isAdmin ? 5: 4,
        //length: 4,
        child: Scaffold(
          bottomNavigationBar: Material(
            //color: Colors.grey,
            child: Container(
              //height: 65,
              //color: Color.fromARGB(100, 24, 24, 24),
              child: TabBar(
                //labelColor: Colors.white,
                //indicatorSize: ,
                //controller: ctr,
                //labelStyle: ,
                /*labelStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),*/
                //labelColor: Colors.pink,

                //unselectedLabelColor: Colors.black,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 0.0),
                    insets: EdgeInsets.symmetric(horizontal:16.0)
                ),
                //indicator: TabInd
                onTap: (index) {
                  print('--------- on tap $index --------');
                  /*if (index == 1 ){
                    if(isAdmin) {
                      Navigator.pushNamed(context, '/AdminHome');
                    }
                    if(isSuper) {
                      Navigator.pushNamed(context, '/AdminHome');
                    }
                  }*/
                },
                tabs: isAdmin ? _buildTabBarAdmin(isSuper) : _buildTabBar(currentUser),
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
                //color: Colors.pink,
                /*boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -1),
                      blurRadius: 2.0
                  )
                ]*/
              ),
            ),
          ),
          body: TabBarView(
            //controller: ctr,
            children: isAdmin ? _buildPageAdmin(isSuper) : _buildPage(currentUser),
          ),
        ),
      );
    }



  _buildTabBarAdmin(bool isSuper) {

    return <Widget>[
      Tab(child: Text('레슨', style: TextStyle(
        fontSize: 12
      ),),),
      Tab(child: Text('채팅', style: TextStyle(
          fontSize: 12
      ),),),
      /*isSuper ? Tab(child: Text('영자방', style: TextStyle(
          fontSize: 12
      ),),)

      : Tab(child: Text('강사', style: TextStyle(
        fontSize: 12
      ),),),

       */

      isSuper ? Tab(child: GestureDetector(
        child: Text('영자방',
          style: TextStyle(
              fontSize: 12
          ),
          strutStyle: StrutStyle(
            fontSize: 10,
            height: 1,
            leading: 0,
          ),),
        onTap: () {
          //Navigator.push(context, MaterialPageRoute(builder: (_) => AdminHome()));
          Navigator.pushNamed(context, '/AdminHome');
          //Navigator.push(context, '');
        },
      ),)

      : Tab(child: Text('강사', style: TextStyle(
        fontSize: 12
      ),),),

      Tab(child: Text('Q&A', style: TextStyle(
          fontSize: 12
      ),),),
      Tab(child: Text('MY', style: TextStyle(
          fontSize: 12
      ),),),
    ];

  }

  _buildTabBar(CurrentUser user) {
    return <Widget>[
      Tab(child: Text('레슨', style: TextStyle(
          fontSize: 12
      ),),),
      Tab(child: Text('채팅', style: TextStyle(
          fontSize: 12
      ),),),
      Tab(child: Text('Q&A', style: TextStyle(
        fontSize: 12
      ),),),
      user.data.mb_id == '' ?
      Tab(child: Text('로그인', style: TextStyle(
          fontSize: 12
      ),),)
      : Tab(child: Text('MY', style: TextStyle(
          fontSize: 12
      ),),),
    ];
  }

  _buildPageAdmin(bool isSuper) {
    return <Widget>[
      LessonListPage(),
      ChatListPage(),
      isSuper ? AdminHome() : MyLessonListPage(),
      BbsListPage(),
      MyPage(),
    ];

  }

  _buildPage(CurrentUser user) {
    return <Widget>[
      LessonListPage(),
      ChatListPage(),
      BbsListPage(),
      user.data.mb_id == '' ? LoginPage(isPreviousTabView: true)
      : MyPage(),
    ];
  }

}


