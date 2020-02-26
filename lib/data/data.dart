import 'package:flutter/material.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final _host = 'https://www.kbschool.co.kr';
final _appdir = '_mobileapp/kangmon';
final _appUrl = _host + '/' + _appdir;

final loginUrl = _appUrl + '/login_check.php';
final registerUrl = _appUrl + '/login_check.php';

final lessonRegisterUrl = _appUrl + '/login_check.php';
final lessonListUrl = _appUrl + '/login_check.php';
final lessonInfoUrl = _appUrl + '/login_check.php';

final portfolioRegisterUrl = _appUrl + '/login_check.php';
final portfolioInfoUrl = _appUrl + '/login_check.php';


final photoRegisterUrl = _appUrl + '/upload_photo.php';
final getPhotosUrl = _appUrl + '/get_photos.php';



var currentUser = User(
  mb_id: '',
  mb_nick: '',
  mb_hp: ''
);
//var currentUser = User();

final _user1 = User(
  mb_id: 'gt',
  mb_nick: '양종석',
  mb_hp: '010-7223-3791'
);

final _user2 = User(
  mb_id: 'bigmsg',
  mb_nick: '김춘식',
  mb_hp: '010-5580-1245'
);

final _user3 = User(
  mb_id: 'travelcar',
  mb_nick: '진현주',
  mb_hp: '010-2000-3232'
);

final _user4 = User(
  mb_id: 'travelcar',
  mb_nick: '홍길동',
  mb_hp: '010-2000-3232'
);

final List<User> users = [
  _user1, _user2, _user3, _user4, _user1
];


final _portfolio1 = Portfolio(
  user: _user1,
  career: ['MBC아카데미 전임강사\n나홀로아카데미'],
  imgUrl: ['assets/images/1.jpg', 'assets/images/1-1.jpg']
);

final _portfolio2 = Portfolio(
  user: _user2,
  career: ['MBC아카데미 전임강사\n나홀로아카데미'],
  imgUrl: ['assets/images/2.jpg', 'assets/images/2-1.jpeg']
);

final t1 = "hello";

final _portfolio3 = Portfolio(
  user: _user3,
  career: ['MBC아카데미 전임강사\n나홀로아카데미'],
  imgUrl: ['assets/images/3.jpg', 'assets/images/3-1.jpg']
);

final _lesson1 = Lesson(
  user: _user1,
  portfolio: _portfolio1,
  subject: '피부자격증 실기 소그룹코칭합니다.',
  content: '많이 떨어져서 어떻게 해야 할지 모르시는 분\n100%책임 합격보장합니다.',
  category: '피부자격증',
  price: 350000,
  term: 5,
  local: '서울 강남구',

);

final _lesson2 = Lesson(
  user: _user2,
  portfolio: _portfolio2,
  subject: '메컵 실기 책임 합격!!',
  content: '많이 떨어져서 어떻게 해야 할지 모르시는 분\n100%책임 합격보장합니다.',
  category: '메컵자격증',
  price: 350000,
  term: 5,
  local: '서울 강남구',
);

final _lesson3 = Lesson(
  user: _user3,
  portfolio: _portfolio3,
  subject: '헤어실기 100%합격',
  content: '많이 떨어져서 어떻게 해야 할지 모르시는 분\n100%책임 합격보장합니다.',
  category: '헤어자격증',
  price: 350000,
  term: 5,
  local: '서울 강남구',
);



final _post1 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '강사등록은 어떻게 하나요?',
  wr_content: """애들보랴.\n
 실기도취소하려다연장하고,\n예약도100%취소.\n
아.진짜요즘은 패닉상태입니다\n\n
진짜\n
왜케우울할까요\n
저만그런가요\n
밤마다 잠이안와요\n
 실기도취소하려다연장하고,\n예약도100%취소.\n
아.진짜요즘은 패닉상태입니다\n\n
진짜\n
왜케우울할까요\n
저만그런가요\n
밤마다 잠이안와요\n
 실기도취소하려다연장하고,\n예약도100%취소.\n
아.진짜요즘은 패닉상태입니다\n\n
진짜\n
왜케우울할까요\n
저만그런가요\n
밤마다 잠이안와요\n
 실기도취소하려다연장하고,\n예약도100%취소.\n
아.진짜요즘은 패닉상태입니다\n\n
진짜\n
왜케우울할까요\n
저만그런가요\n
밤마다 잠이안와요\n
인생곧불혹인데\n""",
  wr_datetime: '2020-02-25 09:00',
);
final _post2 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '승인해주세요.',
  wr_content: '비밀번호 변경 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
);

final _post3 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '광고문의합니다.',
  wr_content: '강사등록 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
);

final _post4 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '통화가 되질 않습니다.',
  wr_content: '강사등록 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
);

final _post5 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '점프는 어떻게 하나요?',
  wr_content: '강사등록 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
);

final List<Post> posts = [
  _post1, _post2, _post3, _post4, _post5
];

final List<Post> comments = [
  _post2, _post3, _post4, _post5
];


final List<Lesson> lessons = [
  _lesson1, _lesson2, _lesson3
];




class LessonPhotos with ChangeNotifier { // with: implement 의 선택적 구현가능함
  List<dynamic> _image = [null, null, null, null, null, null];
  List<dynamic> get image => _image;

  LessonPhotos() {
    fetch();
  }

  void fetch() async {
    print('LessonPhotos fetch()');
    print('start request');
    var res = await http.get(getPhotosUrl);
    print('end request');
    print(res.body);

    var js = json.decode(res.body);
    //List<dynamic> photos = [];
    //_image = [];
    for(var i=0; i< js.length; i++) {
      print(js[i]);
      if (js[i] == 'null') {
        _image[i] = null;
      } else {
        _image[i] = js[i];
      }
    }
    print(_image);
    notifyListeners();
  }

  void change(int index, dynamic url) {
    _image[index] = url;
    notifyListeners();
  }

  void remove(int index)  {
    _image[index] = null;
    notifyListeners();
  }

}
