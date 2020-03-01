import 'dart:convert';

import 'package:flutter_kangmon/data/data.dart';
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';




class MyRequests {
  static final MyRequests _singleton = MyRequests._internal();
  //SharedPreferences pref;

  factory MyRequests() {
    return _singleton;
  }

  MyRequests._internal()  {
    //getPref();
  }


  /*getPref() async {
    pref = await SharedPreferences.getInstance();
  }*/

  post(String url, {Map<String, dynamic> body}) async {
    await setCookies();

    var res = await Requests.post(url, body: body);
    return res;
  }

  get(String url) async {
    await setCookies();

    var res = await Requests.get(url);
    return res;
  }

  setCookies() async {
    String hostname = Requests.getHostname(appUrl);
    SharedPreferences pref = await SharedPreferences.getInstance();
    /*if (pref.containsKey('cookies')) {
      print('have cookies');
    } else {
      print('not cookies');
    }*/
    if(pref.containsKey('cookies')) {
      var cookies = json.decode(pref.getString('cookies'));

      if(cookies['key_ck_mb_id'] != '') {
      //await Requests.clearStoredCookies(hostname);
        await Requests.setStoredCookies(hostname, {
          //'device_id': cookies['device_id'],
          'PHPSESSID': cookies['PHPSESSID'],
          cookies['key_device_id']: cookies['val_device_id'],
          cookies['key_ck_mb_id']: cookies['val_ck_mb_id'],
          cookies['key_ck_auto']: cookies['val_ck_auto'],
        });
      }
    }
  }

}