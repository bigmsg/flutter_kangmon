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
class LessonPhotos with ChangeNotifier { // with: implement 의 선택적 구현가능함
  List<dynamic> _image = [null, null, null, null, null, null];
  int _wr_id;
  int get wr_id => _wr_id;
  List<dynamic> get image => _image;

  LessonPhotos() {
    //fetch();
  }

  // 서버데이터 가져오기
  void fetch(int wr_id,List<dynamic> images) {
    _wr_id = wr_id;
    _image = images;
    notifyListeners();
  }

  void get(int wr_id) async {
    //var res = await http.get(getPhotosUrl+ "?wr_id=${wr_id}");
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
  Future<String> upload(File file, int index) async {

    //1. 서버업로드
    //print('upload... $index');
    //print('wr_id: ${_wr_id}');
    if (_wr_id <= 0) {
      return '❌ 업로드실패: 레슨이 선택되지 않았습니다.\n(레슨내용을 먼저 등록후 사진업로드 하세요)';
    }

    _image[index] = 0;
    notifyListeners();

    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    var params = {
      "image": base64Image,
      "name": fileName,
    };

    var res = await request.post(
      photoRegisterUrl+'?wr_id=${_wr_id}',
      body: params,
    );

    if (res.statusCode == 200) {
      _image[index] = res.content();
      notifyListeners();
      return '👍 업로드 성공';
    } else {
      _image[index] = null;
      notifyListeners();
      return '❌ 업로드 실패';
    }



    /*http.post(photoRegisterUrl, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print('upload result');
      print(res.statusCode);
      print(res.body);

      _image[index] = res.body;
      notifyListeners();
    }).catchError((err) {
      print('upload error');
      print(err);
    });*/

    print(' upload end ');

  }

  // 데이터 삭제
  void remove(int index)  {

    // 서버삭제

    _image[index] = null;
    notifyListeners();
  }

  void initial() {
    _wr_id = 0;
    _image = [null, null, null, null, null, null];
  }

}
