

import 'package:flutter_kangmon/data/data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserBloc {
  final _userSubject = BehaviorSubject<User>();
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
          mb_nick: pref.getString('mb_nick'),
          mb_hp: pref.getString('mb_hp')
      );
      _userSubject.add(user);
    } else {
      _userSubject.add(null);
      //user = User(mb_id: '', mb_nick: '', mb_hp: '');
    }
  }

}


class User {
  String mb_nick;
  String mb_id;
  String mb_hp;

  User({this.mb_nick, this.mb_id, this.mb_hp});
}


class Portfolio {
  final User user;
  final List<String> career;
  final List<String> imgUrl;

  Portfolio({this.user, this.career, this.imgUrl});
}


class Lesson {
  final User user;
  final Portfolio portfolio;
  final String subject;
  final String content;
  final int term;
  final int price;
  final String local;
  final String category;

  Lesson({this.user, this.portfolio, this.subject, this.content, this.term, this.price, this.local, this.category });
}


class Post {
  int wr_id;
  String mb_id;
  String mb_nick;
  String wr_subject;
  String wr_content;
  String wr_datetime;

  Post({this.wr_id, this.mb_id, this.mb_nick, this.wr_subject, this.wr_content, this.wr_datetime});
}