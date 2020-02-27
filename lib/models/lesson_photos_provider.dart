import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kangmon/data/data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'lesson.dart';


/*
  레슨사진등록: 서버 가져오기, 서버 업로드
 */
class LessonPhotos with ChangeNotifier { // with: implement 의 선택적 구현가능함
  List<dynamic> _image = [0, 0, 0, 0, 0, 0];
  List<dynamic> get image => _image;

  LessonPhotos() {
    fetch();
  }

  // 서버데이터 가져오기
  void fetch() async {
    var res = await http.get(getPhotosUrl);

    var js = json.decode(res.body);

    _image = [];
    js.forEach((item) {
      _image.add(item);
    });

    notifyListeners();
  }

  // 데이터 교체
  // url: null(없음), 0(업로드중), 'https://...' 3개중 1개 가능
  void upload(File file, int index) {

    //1. 서버업로드
    print('upload... $index');

    //photos.change(index, 0);
    _image[index] = 0;
    notifyListeners();

    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    http.post(photoRegisterUrl, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
      print(res.body);

      _image[index] = res.body;
      notifyListeners();
    }).catchError((err) {
      print(err);
    });

  }

  // 데이터 삭제
  void remove(int index)  {

    // 서버삭제

    _image[index] = null;
    notifyListeners();
  }

}
