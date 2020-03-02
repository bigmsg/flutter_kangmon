import 'package:flutter/material.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/main.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson_photos_provider.dart';
import 'package:flutter_kangmon/models/my_lessons_bloc.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/models/registering_lesson_provider.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_content_register_page.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_detail_page.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_register_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_profile_register_page.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'package:flutter_kangmon/data/data.dart';

import '../member/login_page.dart';
import '../teacher/profile_register_page.dart';




class MyLessonListPage extends StatefulWidget {
  @override
  _MyLessonListState createState() => _MyLessonListState();
}

class _MyLessonListState extends State<MyLessonListPage> {

  @override
  initState() {
    super.initState();
    //this.getData();
    initialApp();
    myLessonsBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {

    var currentUser = Provider.of<CurrentUser>(context);
    var currentLesson = Provider.of<RegisteringLessonProvider>(context, listen: false);
    var photoProvider = Provider.of<LessonPhotos>(context, listen: false);
    //lessonsBloc.fetch('mico_lesson');
   //lessonsBloc.fetch('mico_lesson');
    //var myLessonsBloc = MyLessonsBloc();
    myLessonsBloc.data.last.then((data) {
      print('-------- myLesson block data --------');
      print(data);
    });

    return Scaffold(
      appBar: AppBar(

        //centerTitle: true,
        title: Text('레슨', style: TextStyle(
            fontSize: 20.0
        ),),
        //backgroundColor: appBarBackgroundColor,

        flexibleSpace: FlexibleSpaceBar(title: Text(''),),
        //toolbarOpacity: 0.1,
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => TeacherProfileRegisterPage()));

            }
          ),
          currentUser.data.mb_id == '' ? _buildLogin(context) : _buildLogout(context, currentUser),

        ],

      ),

      bottomSheet: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).buttonColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.white10,
                  offset: Offset(0, -0.1),
                  blurRadius: 0.5
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              StreamBuilder<Object>(
                stream: myLessonsBloc.data,
                builder: (context, snapshot) {

                  // snapshot.data.length 를 쓰지 못함, 아래소스에서는 사용가능한데... 반복사용하면 한쪽은 안되나?
                  if(snapshot.hasData) {
                    print('------ snapshot data -------');
                    print(snapshot.data);
                    return InkWell(
                      child: Text('👉 레슨등록',
                          style: TextStyle(
                            color:Colors.grey,
                          )),
                      onTap: () {
                        currentLesson.remove();
                        photoProvider.initial();
                        Navigator.push(context, MaterialPageRoute(builder: (_) => LessonRegisterPage()));
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => BbsCommentRegisterPage(post: widget.post, w: 'c')));
                      },
                    );
                  } else {
                    return Text('euoe');
                  }
                }
              ),
            ],
          ),
        ),
      ),

      body: Container(
        child: StreamBuilder(
          stream: myLessonsBloc.data,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data.length > 0) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Lesson lesson = snapshot.data[index];
                  return _buildLesson(context, lesson);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 0.5,
                    color: Colors.grey,
                  );
                },
              );
            } else {
              return Center(
                  child: Text('등록된 나의 레슨이 없습니다.')
              );
            }
          },
        ),
      ),

    );
  }


  _buildLesson(BuildContext context, Lesson lesson) {

    var currentLesson = Provider.of<RegisteringLessonProvider>(context, listen: false);
    var photosProvider = Provider.of<LessonPhotos>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      //color: Color.fromARGB(0, 255, 255, 255),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: /*Hero(
                      tag: lesson.wr_photos.length > 0 ? lesson.wr_photos[0] : lesson.wr_id.toString(),
                      child:*/ Image(
                      width: 120.0,
                      height: 80.0,
                      image: lesson.wr_photos.length > 0 ? NetworkImage(lesson.wr_photos[0]) :  AssetImage('assets/images/1-1.jpg'),
                      //image: AssetImage('assets/images/1-1.jpg'),
                      //image: AssetImage('assets/images/1.jpg'),
                      fit: BoxFit.cover,
                    ),
                    //),
                  ),

                  SizedBox(width: 10.0),
                  Container(
                    //margin: EdgeInsets.all(10.0),
                    //padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(lesson.wr_subject, style:
                        TextStyle(
                            fontWeight: FontWeight.w600
                        ),),
                        Text('지역: ${lesson.wr_local == '' ? '-' : lesson.wr_local}'),
                        Text('금액: ${lesson.wr_price}'),
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
          SizedBox(height: 30,),

          Row(
            children: <Widget>[
              SizedBox(
                width: 70,
                height: 30,
                child: RaisedButton(
                  child: Text(
                    "점프",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  color: Colors.blueGrey,
                  onPressed: (){},
                ),
              ),
              SizedBox(width: 30,),

              SizedBox(
                width: 70,
                height: 30,
                child: RaisedButton(
                  child: Text(
                    "보기",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  color: Theme.of(context).buttonColor,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LessonDetailPage(lesson: lesson))
                    );
                  },
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(
                width: 70,
                height: 30,
                child: RaisedButton(
                  child: Text(
                    "수정",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    currentLesson.fetch(lesson);
                    photosProvider.fetch(lesson.wr_id, lesson.wr_photos);
                    Navigator.push(context, MaterialPageRoute(builder: (_) =>LessonRegisterPage()));
                  },
                ),
              ),


            ],
          )
        ],
      ),
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


