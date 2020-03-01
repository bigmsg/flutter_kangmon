import 'package:flutter/material.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/main.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson_photos_provider.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_content_register_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_profile_register_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

import '../member/login_page.dart';
import 'lesson_detail_page.dart';
import '../teacher/profile_register_page.dart';




class LessonListPage extends StatefulWidget {
  @override
  _LessonListState createState() => _LessonListState();
}

class _LessonListState extends State<LessonListPage> {


  @override
  initState() {
    super.initState();
    //this.getData();
    initialApp();
  }

  @override
  Widget build(BuildContext context) {

    var currentUser = Provider.of<CurrentUser>(context);

    return Scaffold(
      appBar: AppBar(

        //centerTitle: true,
        title: Text('미코', style: TextStyle(
            fontSize: 20.0
        ),),

        flexibleSpace: FlexibleSpaceBar(title: Text(''),),
        //titleSpacing: EdgeInsets.all(0.0),

        actions: <Widget>[
          FlatButton(
              child: Text('설정'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TeacherProfileRegisterPage()));
                //MaterialPageRoute(builder: (_) => TestPage()));
              }
          ),
          FlatButton(
            child: Text('강사등록'),
            onPressed: () =>

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TeacherProfileRegisterPage())),
          ),
          currentUser.data.mb_id == '' ? _buildLogin(context) : _buildLogout(context, currentUser),

        ],
      ),
      body: Container(
        child: ListView.separated(
            itemCount: lessons.length,
            itemBuilder: (BuildContext context, int index) {
              Lesson lesson = lessons[index];
              return _buildLesson(context, lesson);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 0.5,
                color: Colors.grey,
              );
          },

        ),
      ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Hero(
                      tag: lesson.portfolio.imgUrl[0],
                      child: Image(
                        width: 120.0,
                        height: 80.0,
                        image: AssetImage(lesson.portfolio.imgUrl[0]),
                        //image: AssetImage('assets/images/1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(width: 10.0),
                  Container(
                    //margin: EdgeInsets.all(10.0),
                    //padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(lesson.subject, style:
                        TextStyle(
                            fontWeight: FontWeight.w600
                        ),),
                        Text(lesson.local),
                        //Text('${lesson.price}'),
                      ],
                    ),
                  ),

                ],
              ),

              //Image.network('http://www.massagemania.co.kr/data/file/gooin/237413926_WfK3t6Ew_0333f3c1fc1a637708742af47c1edc3566074dce.jpg', width: 100.0, height: 100.0),
              /*Container(
                margin: EdgeInsets.all(10.0),
                child: Text('hello'),
              ),*/


              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.white70,
              ),

            ],
          ),
        )
    );

  }

  _buildLogin(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.alarm_add),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
    //CircularProgressIndicator();
  }

  _buildLogout(BuildContext context, CurrentUser currentUser) {

    return FlatButton(
      child: Text('${currentUser.data.mb_nick} 님(logout)',),
      onPressed: () {
        logout(context);
      },
    );
  }


}


