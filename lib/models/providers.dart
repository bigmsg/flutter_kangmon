import 'dart:io';

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
  User _currentUser = User(
      mb_id: '', mb_password: '', mb_group: '', mb_nick: '', mb_hp: '', mb_photo: ''
  ); // 초기값 설정가능

  get data => _currentUser;

  CurrentUser() {
    fetch();
  }

  void fetch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.containsKey('userInfo')) {
      var userInfo = json.decode(pref.getString('userInfo'));
      _currentUser = User(
        mb_id: userInfo['mb_id'],
        mb_group: userInfo['mb_group'],
        mb_nick: userInfo['mb_nick'],
        mb_hp: userInfo['mb_hp'],
        mb_photo: userInfo['mb_photo']
      );

    } else {
      _currentUser = User(
          mb_id: '', mb_password: '', mb_nick: '', mb_group: '', mb_hp: '', mb_photo: ''
      );
    }

    notifyListeners();
  }

}



