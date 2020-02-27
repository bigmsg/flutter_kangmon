import 'package:flutter/material.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/main.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson_photos_provider.dart';
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

  Future<String> getData() async {
    /*Future<String> response = await http.get(
      Uri.encodeFull('https://'),
      headers: {'Accept': 'application/json'}
    );*/
    //var response = await http.get('https://www.massagemania.co.kr/_mobileapp/admin/test.php', body: {});
    /*var response = await http.post('https://www.massagemania.co.kr/_mobileapp/admin/test.php', body: {'mb_id': 'mania'});
    print(response.body);


     */
    var response = await http.post('https://www.massagemania.co.kr/_mobileapp/admin/test.php',
        body: {'mb_id': 'mania'}).then(
            (http.Response response) {
          final int statusCode = response.statusCode;
          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
          print(response.body);
          //return json.decode(response.body);
        });
    print(response);
    return '00';
  }

  /*Future getData() async {

  }*/

  @override
  initState() {
    super.initState();
    this.getData();
    initialApp();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                    Text(lesson.subject, style:
                      TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                      ),),
                    Text(lesson.local, style: TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.
                    ),),
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


