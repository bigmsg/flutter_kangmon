import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_list_page.dart';
import 'package:flutter_kangmon/pages/member/login_page.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_list_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_register_page.dart';

import '../main.dart';
import 'lesson/lesson_detail_page.dart';
import 'member/mypage_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /*TabController ctr;
  @override void initState() {
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
    //return LessonListPage();
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            //centerTitle: true,
            title: Text('미용자격증 코칭몬',
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
                onPressed: () =>
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TeacherRegisterPage())),
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
                        MaterialPageRoute(builder: (_) => TeacherRegisterPage())),
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
            color: Colors.grey,
            child: TabBar(
              //controller: ctr,
              tabs: <Widget>[
                Tab(child: Text('레슨', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),),
                Tab(child: Text('레슨관리', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),),
                Tab(child: Text('게시판', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),),

                Tab(child: Text('MY', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),),


              ],
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
          logout();
        },
      );
    }

    _buildLesson(BuildContext context, Lesson lesson) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LessonDetailPage(lesson: lesson))
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Hero(
                    tag: lesson.portfolio.imgUrl[0],
                    child: Image(
                      width: 80.0,
                      height: 50.0,
                      image: AssetImage(lesson.portfolio.imgUrl[0]),
                      //image: AssetImage('assets/images/1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                //Image.network('http://www.massagemania.co.kr/data/file/gooin/237413926_WfK3t6Ew_0333f3c1fc1a637708742af47c1edc3566074dce.jpg', width: 100.0, height: 100.0),
                /*Container(
                margin: EdgeInsets.all(10.0),
                child: Text('hello'),
              ),*/
                SizedBox(width: 10.0),
                Container(
                  //margin: EdgeInsets.all(10.0),
                  //padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(lesson.subject),
                      Text(lesson.local),
                      //Text('${lesson.price}'),
                    ],
                  ),
                ),

              ],
            ),
          )
      );

    }


}


