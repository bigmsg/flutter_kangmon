import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kangmon/data/data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'lesson.dart';

class TestUser with ChangeNotifier {
  User _user = User(
      mb_id: 'mania',
      mb_nick: '홍길동',
      mb_group: 'teacher',
      mb_hp: '010-2278-1282',
      mb_password: 'dizzy8000',
      mb_photo: ''
  );
  get data => _user;

  TestUser() {
    notifyListeners();
  }

  setState(User user) {
    _user = user;
    notifyListeners();
  }

  change(User user) {
    _user = user;
  }

}

class CurrentUser extends ChangeNotifier {
  User _currentUser = User(mb_id: '', mb_password: '', mb_group: '', mb_nick: '', mb_hp: '', mb_photo: ''); // 초기값 설정가능

  get data => _currentUser;

  CurrentUser() {
    fetch();
  }

  void fetch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.containsKey('mb_id')) {
      _currentUser = User(
        mb_id: pref.getString('mb_id'),
        mb_group: pref.getString('mb_group'),
        mb_nick: pref.getString('mb_nick'),
        mb_hp: pref.getString('mb_hp'),
        mb_photo: pref.getString('mb_photo'),
      );

    } else {
      _currentUser = User(mb_id: '', mb_password: '', mb_nick: '', mb_group: '', mb_hp: '', mb_photo: '');
    }

    notifyListeners();
  }

}



/*
  레슨사진등록: 서버 가져오기, 서버 업로드
 */
class LessonPhotos with ChangeNotifier { // with: implement 의 선택적 구현가능함
  List<dynamic> _image = [0, 0, 0, 0, 0, 0];
  List<dynamic> get image => _image;

  LessonPhotos() {
    fetch();
  }

  void fetch() async {
    //print('LessonPhotos fetch()');
    //print('start request');
    var res = await http.get(getPhotosUrl);
    //print('end request');
    //print(res.body);

    var js = json.decode(res.body);
    //List<dynamic> photos = [];
    //_image = [];
    for(var i=0; i< js.length; i++) {
      //print(js[i]);
      //_image = js[i];
      if (js[i] == null) {
        _image[i] = null;
      } else {
        _image[i] = js[i];
      }
    }
    //print(_image);
    notifyListeners();
  }

  void change(int index, dynamic url) {
    _image[index] = url;
    notifyListeners();
  }

  void remove(int index)  {
    _image[index] = null;
    notifyListeners();
  }

}
