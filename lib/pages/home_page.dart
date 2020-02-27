import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_list_page.dart';
import 'package:flutter_kangmon/pages/member/login_page.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_list_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_profile_register_page.dart';
import 'package:provider/provider.dart';

import '../main.dart';
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

    var mbGroup = '';

    print('mbGRoup start');
    var cUser = currentUserBloc.data.last;
    cUser.then((user) {
        mbGroup = user.mb_group;
        print('group: ' + mbGroup);
    });


    //return LessonListPage();
    return DefaultTabController(
        length: mbGroup == 'super' ? 5: 4,
        child: Scaffold(
          appBar: AppBar(
            //centerTitle: true,
            title: Text('미용코칭몬',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            /*leading: IconButton(
            icon: Icon(Icons.account_circle),
            iconSize: 30.0,
            onPressed: () {},
          ),*/
            actions: <Widget>[
              FlatButton(
                child: Text('설정',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TeacherProfileRegisterPage()));
                        //MaterialPageRoute(builder: (_) => TestPage()));
                  }
              ),
              FlatButton(
                child: Text('강사등록',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () =>

                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TeacherProfileRegisterPage())),
              ),
              StreamBuilder<User>(
                stream: currentUserBloc.data,
                builder: (context, snapshot) {
                  //if(snapshot.hasData && snapshot.data.mb_id != '') {
                  if (snapshot.hasData) {
                    return _buildLogout(context);
                  } else {
                    return _buildLogin(context);
                  }
                },
              ),

            ],
          ),
          bottomNavigationBar: Material(
            //color: Colors.grey,
            child: Container(
              //height: 65,
              child: TabBar(
                //controller: ctr,

                tabs: <Widget>[
                  Tab(child: Text('레슨', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  ),),),
                  Tab(child: Text('레슨관리', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  ),),),
                  Tab(child: Text('게시판', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  ),),),

                  Tab(child: Text('MY', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  ),),),

                ],
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
            children: <Widget>[
              LessonListPage(),
              Text('레슨관리'),
              BbsListPage(),
              MyPage(),

            ],
          ),
        ),
      );
    }

    _buildLogin(BuildContext context) {
      return /*FlatButton(
      child: Text('Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );*/
        IconButton(
          icon: Icon(Icons.alarm_add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        );
      //CircularProgressIndicator();
    }

    _buildLogout(BuildContext context) {
      return FlatButton(
        child: Text('Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        onPressed: () {
          logout(context);
        },
      );
    }


}


