import 'package:flutter/material.dart';
import 'package:flutter_kangmon/help/my_requests.dart';
import 'package:flutter_kangmon/models/board_bloc.dart';
import 'package:flutter_kangmon/models/comment_bloc.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/lessons_bloc.dart';
import 'package:flutter_kangmon/models/my_lessons_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final _host = 'https://www.kbschool.co.kr';
final _appdir = '_mobileapp/kangmon';
final _bbsdir = 'bbs';
final appUrl = _host + '/' + _appdir;

final loginUrl = appUrl + '/login_check.php';
final logoutUrl = appUrl + '/logout.php';
final registerUrl = appUrl + '/login_check.php';

final lessonUpdateUrl = appUrl + '/${_bbsdir}/lesson_update.php';
final lessonListUrl = appUrl + '/${_bbsdir}/lesson_list.php';
final lessonInfoUrl = appUrl + '/login_check.php';

final portfolioRegisterUrl = appUrl + '/login_check.php';
final portfolioInfoUrl = appUrl + '/login_check.php';

final bbsListUrl = appUrl + '/${_bbsdir}/list.php';
final bbsUpdateUrl = appUrl + '/${_bbsdir}/write_update.php';
final bbsCommentListUrl = appUrl + '/${_bbsdir}/comment_list.php';
final bbsCommentUpdateUrl = appUrl + '/${_bbsdir}/write_comment_update.php';


final photoRegisterUrl = appUrl + '/upload_photo.php';
final getPhotosUrl = appUrl + '/get_photos.php';



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