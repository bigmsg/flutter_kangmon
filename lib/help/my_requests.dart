import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_kangmon/data/data.dart';
import 'package:http_parser/http_parser.dart';


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

  Future<dynamic> post(String url, {Map<String, dynamic> body}) async {
    await setCookies();

    var res = await Requests.post(url, body: body);
    return res;
  }

  Future<dynamic> get(String url) async {
    await setCookies();

    var res = await Requests.get(url);
    return res;
    /*Requests.get(url).then((response) {
      return response;
    });*/
  }

  Future<dynamic> multipart(String url, {Map<String, dynamic> body, File file}) async {

    var cookies = await getCookieString();
    var headers = {
      'cookie': cookies,
    };

    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll(body);
    request.headers.addAll(headers);
    request.files.add(
        await http.MultipartFile.fromPath(
            'files[]', file.path,
            contentType: MediaType('image', 'jpeg'))
    );

    print('---------- uploading .... -----------');
    var response = await request.send();
    if (response.statusCode == 200) print('Uploaded!');
    //print(response.headers);
    /*response.stream.bytesToString().then((val) {
      print(val);
    });*/

    return response;
  }

  //multipart(String url, {})

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

  Future<String> getCookieString() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var cookies = '';
    if(pref.containsKey('cookies')) {
      var cookieInfo = json.decode(pref.getString('cookies'));

      if (cookieInfo['key_ck_mb_id'] != '') {
        cookies = 'PHPSESSID=${cookieInfo['PHPSESSID']};';
        cookies += '${cookieInfo['key_device_id']}=${cookieInfo['val_device_id']};';
        cookies += '${cookieInfo['key_ck_mb_id']}=${cookieInfo['val_ck_mb_id']};';
        cookies += '${cookieInfo['key_ck_auto']}=${cookieInfo['val_ck_auto']};';
      }
    }

    return cookies;
  }



}