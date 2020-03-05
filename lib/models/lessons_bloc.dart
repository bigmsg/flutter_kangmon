import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:requests/requests.dart';
import 'package:rxdart/rxdart.dart';


/*
  게시글 목록 가져오기
  작성: 20.03.02(월)
*/
class LessonsBloc {
  final _lessonsSubject = BehaviorSubject<List<Lesson>>.seeded([]);
  Stream<List<Lesson>> get data => _lessonsSubject.stream;

  LessonsBloc() {
    fetch();
  }

  fetch() async {
    //var res = await request.get(bbsListUrl+'?bo_table=${bo_table}');
    request.get(lessonListUrl+'?bo_table=mico_lesson').then((res) {
      List<Lesson> lessons = [];

      //print(res.content());
      var js = res.json();

      js.forEach((item) {
        lessons.add(jsonToLesson(item));
      });

      _lessonsSubject.add(lessons);
    });



  }
}