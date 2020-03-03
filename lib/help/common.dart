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



class NetworkService {

  final JsonDecoder _decoder = new JsonDecoder();
  final JsonEncoder _encoder = new JsonEncoder();

  Map<String, String> headers = {"content-type": "text/json"};
  Map<String, String> cookies = {};

  void _updateCookie(http.Response response) {
    String allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {

      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires')
          return;

        this.cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0)
        cookie += ";";
      cookie += key + "=" + cookies[key];
    }

    return cookie;
  }

  Future<dynamic> get(String url) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {body, encoding}) {
    return http
        .post(url, body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}