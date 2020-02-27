import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/main.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future initialApp() async {
  //SharedPreferences.setMockInitialValues({});
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(currentUser.mb_id);
  //print('mb_id: ' + pref.getString('mb_id'));

  if (pref.containsKey('mb_id')) {
    print('initialApp(): have key mb_id');
    currentUser.mb_id = pref.getString('mb_id');
    currentUser.mb_group = pref.getString('mb_group');
    currentUser.mb_nick = pref.getString('mb_nick');
    currentUser.mb_hp = pref.getString('mb_hp');
    currentUser.mb_photo = pref.getString('mb_photo');


  } else {
    print('not have key mb_id');
  }
}


Future getShared(String name) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var item = pref.get(name);

  return item;
}

Future setUserInfo(Map<String, String> userInfo) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('mb_id', userInfo['mb_id']);
  pref.setString('mb_password', userInfo['mb_password']);
  pref.setString('mb_group', userInfo['mb_group']);
  pref.setString('mb_nick', userInfo['mb_nick']);
  pref.setString('mb_hp', userInfo['mb_hp']);
  pref.setString('mb_photo', userInfo['mb_photo']);

  /*currentUser.mb_id = userInfo['mb_id'];
  currentUser.mb_nick = userInfo['mb_nick'];
  currentUser.mb_hp = userInfo['mb_hp'];*/
  currentUserBloc.fetch();
}


Future logout(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();
  currentUserBloc.fetch();
  Provider.of<CurrentUser>(context, listen: false).fetch();
}