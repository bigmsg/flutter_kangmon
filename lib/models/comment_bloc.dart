import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:requests/requests.dart';
import 'package:rxdart/rxdart.dart';




/*
  게시글 댓글 목록
  작성: 20.03.01(일)
 */
class CommentsBloc {
  final _commentsSubject = BehaviorSubject<List<Post>>.seeded([]);
  Stream<List<Post>> get data => _commentsSubject.stream;

  fetch(String bo_table, int wr_id) async {
    //var res = await request.get(bbsListUrl+'?bo_table=${bo_table}&wr_id=${wr_id}');
    Requests.get(bbsListUrl+'?bo_table=${bo_table}&wr_id=${wr_id}').then((res){
      List<Post> comments = [];
      print('-------- CommentsBloc fetch -------------');
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
          is_comment: item['is_comment'],
        ));
      });

      _commentsSubject.add(comments);
    });



  }
}