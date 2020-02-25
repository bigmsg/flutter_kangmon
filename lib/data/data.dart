import 'package:flutter_kangmon/models/lesson.dart';

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


final List<Lesson> lessons = [
  _lesson1, _lesson2, _lesson3
];


