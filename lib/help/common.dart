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



Future initialApp() async {
  //SharedPreferences.setMockInitialValues({});
  SharedPreferences pref = await SharedPreferences.getInstance();

  print('--------- initial App  --------------');
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

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
