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
  is_comment: false,
);
final _post2 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '승인해주세요.',
  wr_content: '비밀번호 변경 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
  is_comment: false,
);

final _post3 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '광고문의합니다.',
  wr_content: '강사등록 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
  is_comment: false,
);

final _post4 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '통화가 되질 않습니다.',
  wr_content: '강사등록 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
  is_comment: false,
);

final _post5 = Post(
  wr_id: 1,
  mb_id: 'gt',
  mb_nick: '양팀장',
  wr_subject: '강의는 어떻게 결제하나요?',
  wr_content: '강사등록 어떻게 하나요?',
  wr_datetime: '2020-02-25 09:00',
  is_comment: false,
);


final _comment1 = Post(
  wr_id: 1,
  mb_id: 'star5',
  mb_nick: '양팀장',
  wr_subject: null,
  wr_content: '종아리만 합니다.',
  wr_datetime: '2020-02-25 09:00',
  is_comment: true,
);
final _comment2 = Post(
  wr_id: 1,
  mb_id: 'chunsik',
  mb_nick: '김춘식',
  wr_subject: null,
  wr_content: '최근에 보셨나요? 손들고 먼저 허벅에다 한다고말하고 있습니다. \n잘지키세요.\n합격하시고 꼭 후겨 올려주세요.',
  wr_datetime: '2020-02-25 09:00',
  is_comment: true,
);

final _comment3 = Post(
  wr_id: 1,
  mb_id: 'hyunju',
  mb_nick: '진현주',
  wr_subject: null,
  wr_content: '화이팅합니다.\n저도 꼭 합격하고 싶네요.',
  wr_datetime: '2020-02-25 09:00',
  is_comment: true,
);

final _comment4 = Post(
  wr_id: 1,
  mb_id: 'sangsuk',
  mb_nick: '김상석',
  wr_subject: null,
  wr_content: '현주님은 언제 시험인가요?\n피부 보시는 건가요?',
  wr_datetime: '2020-02-25 09:00',
  is_comment: true,
);

final _comment5 = Post(
  wr_id: 1,
  mb_id: 'gildong',
  mb_nick: '홍길동',
  wr_subject: null,
  wr_content: '이제까지 5번 떨어졌어요.\n이번엔 꼭 합격하고 싶네요.',
  wr_datetime: '2020-02-25 09:00',
  is_comment: true,
);

final List<Post> posts = [
  _post1, _post2, _post3, _post4, _post5
];

final List<Post> comments = [
  _comment1, _comment2, _comment3, _comment4, _comment5
];


final List<Lesson> lessons = [
  _lesson1, _lesson2, _lesson3
];





final currentUserBloc = CurrentUserBloc();
final lessonPhotosBloc = LessonPhotoBloc();