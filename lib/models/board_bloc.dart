import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:requests/requests.dart';
import 'package:rxdart/rxdart.dart';



/*
  게시글 목록 가져오기
  작성: 20.03.01(일)
*/
class BoardBloc {
  final _boardSubject = BehaviorSubject<List<Post>>.seeded([]);
  Stream<List<Post>> get data => _boardSubject.stream;

  fetch(String bo_table) async {
    //var res = await request.get(bbsListUrl+'?bo_table=${bo_table}');
    Requests.get(bbsListUrl+'?bo_table=${bo_table}').then((res) {
      List<Post> comments = [];
      print('-------- PostsBloc fetch -------------');
      print(res.content());
      var js = res.json();

      js.forEach((item) {
        comments.add(Post(
          wr_id: item['wr_id'],
          mb_id: item['mb_id'],
          mb_nick: item['mb_nick'],
          wr_subject: item['wr_subject'],
          wr_content: item['wr_content'],
          wr_datetime: item['wr_datetime'],
          wr_photo: item['wr_photo'],
          is_comment: item['is_comment'],
        ));
      });

      _boardSubject.add(comments);
    });



  }
}