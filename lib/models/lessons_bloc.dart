import 'package:flutter_kangmon/data/data.dart';
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
    Requests.get(lessonListUrl+'?bo_table=mico_lesson').then((res) {
      List<Lesson> lessons = [];
      print('-------- LessonsBloc fetch -------------');
      print(res.content());
      var js = res.json();

      js.forEach((item) {
        List<String> photos = [];
        item['wr_photos'].forEach((val) {
          //if(val != '')
            photos.add(val);
        });
        print('price type: ${item['wr_price']}');
        print('wr_local type: ${item['wr_local']}');
        print('wr_category type: ${item['wr_category']}');


        lessons.add(Lesson(
          wr_id: item['wr_id'],
          mb_id: item['mb_id'],
          mb_nick: item['mb_nick'],
          wr_subject: item['wr_subject'],
          wr_content: item['wr_content'],
          wr_datetime: item['wr_datetime'],
          wr_photos: photos,
          wr_term: item['wr_term'],
          wr_price: item['wr_price'],
          wr_local: item['wr_local'],
          wr_category: item['wr_category'],
        ));


      });
      print(lessons);

      _lessonsSubject.add(lessons);
    });



  }
}