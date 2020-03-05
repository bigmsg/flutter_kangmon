
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_kangmon/data/data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class User {
  String mb_id;
  String mb_password;
  String mb_group;
  String mb_nick;
  String mb_hp;
  String mb_photo;

  User({
    this.mb_id, this.mb_password, this.mb_group,
    this.mb_nick, this.mb_hp, this.mb_photo
  });
}


class Portfolio {
  final User user;
  final List<String> career;
  final List<String> imgUrl;

  Portfolio({this.user, this.career, this.imgUrl});
}

class Lesson {
  int wr_id;
  String mb_id;
  String mb_nick;
  String wr_subject;
  String wr_content;
  String wr_datetime;
  List<dynamic> wr_photos;
  String wr_term;
  int wr_price;
  String wr_local;
  String wr_category;

  Lesson({this.wr_id, this.mb_id, this.mb_nick, this.wr_subject, this.wr_content, this.wr_datetime,
    this.wr_photos,  this.wr_term, this.wr_price, this.wr_local, this.wr_category});
}


class Post {
  int wr_id;
  String mb_id;
  String mb_nick;
  String wr_subject;
  String wr_content;
  String wr_datetime;
  String wr_photo;
  bool is_comment;

  Post({this.wr_id, this.mb_id, this.mb_nick, this.wr_subject, this.wr_content, this.wr_datetime, this.wr_photo, this.is_comment});
}






/*class CurrentUserBloc {
  //final _userSubject = BehaviorSubject<User>();
  final _userSubject = BehaviorSubject.seeded(User()); // 초기값 설정가능
  //final _number = BehaviorSubject.seeded(0); // int 초기값 설정
  //final _list = BehaviorSubject.seeded([]); // list 초기값 설정

  Stream<User> get data => _userSubject.stream;

  CurrentUserBloc() {
    fetch();
  }

  void fetch() async {
    print('CurrentUserBloc fetch()');
    SharedPreferences pref = await SharedPreferences.getInstance();
    User user;
    if(pref.containsKey('mb_id')) {
      user = User(
        mb_id: pref.getString('mb_id'),
        mb_group: pref.getString('mb_group'),
        mb_nick: pref.getString('mb_nick'),
        mb_hp: pref.getString('mb_hp'),
        mb_photo: pref.getString('mb_photo'),
      );
      _userSubject.add(user);
    } else {
      _userSubject.add(null);
      //user = User(mb_id: '', mb_nick: '', mb_hp: '');
    }
  }

}*/


class LessonPhotoBloc {
  List<dynamic> _photos = [0, 0, 0, 0, 0, 0];
  //final _photosSubject = BehaviorSubject<List>.seeded([]);
  final _photosSubject = BehaviorSubject.seeded([]);

  Stream<List<dynamic>> get photos => _photosSubject;

  LessonPhotoBloc() {
    fetch();
  }

  // 서버데이터 가져오기
  void fetch() async {
    var res = await http.get(getPhotosUrl);
    var js = json.decode(res.body);

    _photos = [];
    for(var i=0; i< js.length; i++) {
      //print(js[i]);
      _photos.add(js[i]);
    }
    //print(_photos);
    _photosSubject.add(_photos);
  }

  // 이미지제 교체
  void change(int index, dynamic url) {
    // url: null(없음), 0(업로드중), 'https://...' 3개중 1개 가능
    _photos[index] = url;
    _photosSubject.add(_photos);
  }

  // 이미지 삭
  void remove(int index)  {
    _photos[index] = null;
    _photosSubject.add(_photos);
  }
}

