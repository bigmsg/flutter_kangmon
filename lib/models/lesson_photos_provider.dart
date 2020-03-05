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

  void set(int wr_id) {
    _wr_id = wr_id;
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
  Future<Map<String, dynamic>> upload(File file, int index, Map<String, String> body) async {

    //1. 서버업로드
    //print('upload... $index');
    //print('wr_id: ${_wr_id}');
    if (_wr_id <= 0) {
      return {
        'result': false,
        'message': '❌ 업로드실패: 레슨이 선택되지 않았습니다.\n(레슨내용을 먼저 등록후 사진업로드 하세요)'
      };
    }

    body['wr_id'] = _wr_id.toString();
    _image[index] = '';
    notifyListeners();

    print('------- _wr_id: ${_wr_id} ------------');
    var response = await request.multipart(
        photoRegisterUrl,
        body: body,
        file: file
    );

    print('status code:  ${response.statusCode}');

    var jsonString= await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print('-------- out result ----------');
      print(jsonString);
      //Map<String, dynamic> files1 = jsonDecode(result);
      //Map<String, dynamic> files2 = json.decode(result);

      //print(files1);
      //print(files2);
      var js = json.decode(jsonString);
      print(js);
      if (js['files'] != null) {
        //print(js['files'][0]['name']);
        //print(js['files'][0]['url']);
        //print(js['files'][0]['thumbnailUrl']);
        _image[index] = js['files'][0]['thumbnailUrl'];
        notifyListeners();

        return {
          'result': true,
          'photoUrl': js['files'][0]['url'],
          'thumbnailUrl': js['files'][0]['thumbnailUrl'],
          'message': '👍 업로드 성공'
        };

      /*
        1. 비회원일 경우
        2. bo_table, wr_id, bf_no 값이 없을 경우
        3. 같은 wr_id, bf_no 파일이 있을 경우
      */
      } else {
        _image[index] = null;
        notifyListeners();
        return {
          'result': false,
          'message': js['message'],
        };
      }


    } else {
      _image[index] = null;
      notifyListeners();
      return {
        'result': false,
        'message': '❌ 업로드 실패'
      };
    }

  }

  // 데이터 삭제
  Future<Map<String, dynamic>> remove(int index) async  {
    print(_image[index]);
    var fileName = _image[index].toString().replaceAll('https://www.kbschool.co.kr:443/data/file/mico_lesson/thumbnail/', '');
    print(fileName);

    var url = 'https://www.kbschool.co.kr/_mobileapp/kangmon/jquery-file-upload/gnuboard.php';
    url += '?file=${fileName}';
    url += '&_method=DELETE';



    // 서버삭제
    var res = await request.post(url, body: {
      //'file': '990344487_7haqwxZc_62b787e0d7a3d517917b63c8be760cdc951b0a1a.png',
      //'_method': 'DELETE',
      'table': 'mico_lesson',
      'wr_id': _wr_id.toString(),
      'bf_no': index.toString()
    });

    print('--------- remove result ---------');
    print(res.content());
    var js = res.json();
    if(js[fileName]) {
      _image[index] = null;
      notifyListeners();
      return {
        'result': true,
        'message':'${index + 1}번째 이미지가 삭제되었습니다.'
      };
    } else {
      return {
        'result': false,
        'message':'❌ 삭제 실패(알수 없는 이유)'
      };

    }

  }

  void initial() {
    _wr_id = 0;
    _image = [null, null, null, null, null, null];
  }

  void getFileName(int index) {
    print(_image[index]);
    var uri = Uri.parse(_image[index]);
    uri.queryParameters.forEach((k, v) {
      print('key: $k - value: $v');
    });
  }

}
