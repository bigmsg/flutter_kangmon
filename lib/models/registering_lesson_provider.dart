import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kangmon/data/data.dart';
//import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'lesson.dart';



/*
  레슨사진등록: 서버 가져오기, 서버 업로드
 */
class RegisteringLessonProvider with ChangeNotifier { // with: implement 의 선택적 구현가능함
  Lesson lesson;

  get data => lesson;

  RegisteringLessonProvider({this.lesson});

  fetch(Lesson les) {
    print('------ fetch ------');
    print(les);
    print(les.wr_subject);
    print(les.wr_content);
    lesson = les;
    print(lesson.wr_price);
    notifyListeners();
  }

  remove()  {
    lesson = null;
    notifyListeners();
  }

}
