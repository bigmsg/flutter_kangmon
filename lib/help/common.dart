import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/main.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:provider/provider.dart';
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

Future initialApp() async {
  print('--------- initial App  --------------');
}


Future getShared(String name) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var item = pref.get(name);

  return item;
}

// 로그아웃
void logout(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var res = await Requests.get(logoutUrl);
  print(res.content());
  if (res.statusCode == 200) {
    pref.remove('userInfo');
    pref.remove('cookies');
    Provider.of<CurrentUser>(context, listen: false).fetch();

    // 자동로그인 쿠키삭제
    String hostname = Requests.getHostname(logoutUrl);
    await Requests.clearStoredCookies(hostname);

    myLessonsBloc.remove();
  }
}

/*
  json객체 --> Lesson
 */
Lesson jsonToLesson(Map<String, dynamic> item) {
  //print('--------- converting json to lesson ----------');
  //print(item);
  List<String> photos = [];
  item['wr_photos'].forEach((val) {
    photos.add(val);
  });

  return Lesson(
    wr_id: item['wr_id'],
    mb_id: item['mb_id'],
    mb_nick: item['mb_nick'],
    wr_subject: item['wr_subject'],
    wr_content: item['wr_content'],
    wr_datetime: item['wr_datetime'],
    wr_photos: photos,
    wr_term: item['wr_term'],
    wr_price: item['wr_price'],
    wr_local: item['wr_local'],
    wr_category: item['wr_category'],
  );
}
