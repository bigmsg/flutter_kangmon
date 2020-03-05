import 'package:flutter/material.dart';
import 'package:flutter_kangmon/chat/model/chat_message_bloc.dart';
import 'package:flutter_kangmon/help/my_requests.dart';
import 'package:flutter_kangmon/models/board_bloc.dart';
import 'package:flutter_kangmon/models/comment_bloc.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/lessons_bloc.dart';
import 'package:flutter_kangmon/models/my_lessons_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final _host = 'https://www.kbschool.co.kr';
final _appDir   = '_mobileapp/kangmon';
final _bbsDir   = 'bbs';
final _chatDir  = 'chat';
final _lessonDir = 'lesson';
final appUrl = _host + '/' + _appDir;

final chkAutologinUrl = appUrl + '/chk_auto_login.php';
final loginUrl = appUrl + '/login_check.php';
final logoutUrl = appUrl + '/logout.php';
final registerUrl = appUrl + '/login_check.php';

final lessonUpdateUrl = appUrl + '/${_lessonDir}/lesson_update.php';
final lessonListUrl = appUrl + '/${_lessonDir}/lesson_list.php';
final lessonInfoUrl = appUrl + '/login_check.php';

final portfolioRegisterUrl = appUrl + '/login_check.php';
final portfolioInfoUrl = appUrl + '/login_check.php';

final bbsListUrl = appUrl + '/${_bbsDir}/list.php';
final bbsUpdateUrl = appUrl + '/${_bbsDir}/write_update.php';
final bbsCommentListUrl = appUrl + '/${_bbsDir}/comment_list.php';
final bbsCommentUpdateUrl = appUrl + '/${_bbsDir}/write_comment_update.php';


final sendMessageUrl = appUrl + '/${_chatDir}/write.php';
final chatFetchaAllUrl = appUrl + '/${_chatDir}/fetch_all.php';
final chatFetchUrl = appUrl + '/${_chatDir}/fetch.php';

final photoRegisterUrl = appUrl + '/jquery-file-upload/gnuboard.php';
final getPhotosUrl = appUrl + '/get_photos.php';

enum BtType {
  big,
  small,
  primary
}

//const appBarBackgroundColor = const Color(0xFFCA05FF);
//const appBarBackgroundColor = const Color(0xFF121212);
//const appBarBackgroundColor = const Color.fromARGB(400, 24, 24, 24);


//final currentUserBloc = CurrentUserBloc();
final lessonPhotosBloc = LessonPhotoBloc();
final boardBloc = BoardBloc();
final lessonsBloc = LessonsBloc();
final myLessonsBloc = MyLessonsBloc();
final commentsBloc = CommentsBloc();


final request = MyRequests();

