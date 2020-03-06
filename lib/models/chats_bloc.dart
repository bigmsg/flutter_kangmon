import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:requests/requests.dart';
import 'package:rxdart/rxdart.dart';


/*
  게시글 목록 가져오기
  작성: 20.03.02(월)
*/
class ChatsBloc {
  final _chatsSubject = BehaviorSubject<List<Chat>>.seeded([]);
  Stream<List<Chat>> get data => _chatsSubject.stream;

  ChatsBloc() {
    fetch();
  }

  fetch() async {
    //var res = await request.get(bbsListUrl+'?bo_table=${bo_table}');
    request.get(chatListUrl).then((res) {
      List<Chat> chats = [];

      print('code: ${res.statusCode}');
      print(res.content());
      var js = res.json();

      js.forEach((item) {
        var chat = Chat(
          roomId: item['room_id'],
          roomName: item['room_name'],
          roomPhoto: item['room_photo'],
          newMessageCount: item['new_message_count'],
          lastMessage: item['last_message'],
          lastDatetime: DateTime.parse(item['last_datetime']),
        );
        chats.add(chat);
      });

      _chatsSubject.add(chats);


    });
  }
}


class Chat {
  String roomId;
  String roomName;
  String roomPhoto;
  int newMessageCount;
  String lastMessage;
  DateTime lastDatetime;

  Chat({this.roomId, this.roomName, this.roomPhoto, this.newMessageCount, this.lastMessage, this.lastDatetime});
}