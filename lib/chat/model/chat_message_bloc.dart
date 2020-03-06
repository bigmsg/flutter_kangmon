import 'dart:math';

import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:requests/requests.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

/*
  게시글 목록 가져오기
  작성: 20.03.01(일
*/
class ChatMessageBloc {
  final _boardSubject = BehaviorSubject<List<ChatMessage>>.seeded([]);
  Stream<List<ChatMessage>> get stream => _boardSubject.stream;
  List<ChatMessage> _chats = [];
  String get roomId => chatRoomId;

  String chatRoomId;    // initialFetch() 이후에 설정됨
  String currentUserId;
  String otherUserId;
  String _brightness;

  setChatRoomId(String roomId) {
    chatRoomId = roomId;
    //initialFetch();
  }


  sendMessage(ChatMessage message) async {
    // 서버업로드 이후
    /*{
      id: eda7e164-3707-4a07-a882-33fb76ad0c0e,
      text: fadsfadsfasd,
      image: null,
      video: null,
      createdAt: 1583303587536,
      user: {
        uid: bigmsg2,
        name: 냠냠냠,
        avatar: https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg,
        containerColor: null,
        color: null
      },
      quickReplies: null
    }
    */
    print('--------- in sendMessage() -----------');

    //print(message.toJson());
    //print(message.text);

    var res = await request.post(sendMessageUrl, body: {
      //'brightness': _brightness,
      'other_mb_id': otherUserId,
      'chat_room_id': chatRoomId,
      'chat_text': message.text,
      'chat_image': '',
      'chat_video': '',
    });

    print(res.content());


    if(res.statusCode == 200) {
      var js = res.json();
      if(chatRoomId == null) {
        chatRoomId = js['chat_room_id'];
      }
      print('--------- send result -----------');
      print(js['chat_room_id']);
      var msg = jsonToMessage(js);
      _chats.add(msg);
      _boardSubject.add(_chats);
    } else {
      print('통신실패');
    }

  }

  /*
    일정시간 이후 계속 새 메시지 불러오기
    내가가진 마지막 메시지의 날짜 이후의 메시지를 가져오기
  */
  Future<int> intervalFetch() async {

    if (chatRoomId == null) {
      return 0;
    }

    String lastDateString = '';
    var formatter  = DateFormat('yyyy-MM-dd H:m:s');
    if(_chats.length == 0) {
      lastDateString = '';
    }
    lastDateString = formatter.format(_chats[_chats.length - 1].createdAt);
    print('last datetime: ' + lastDateString);

    var res = await request.post(chatFetchUrl, body: {
      'chat_room_id': chatRoomId,
      //'brightness': _brightness,
      'last_datetime': lastDateString
    });

    print(res.content());

    var js = res.json();
    int newMessageCount = 0;
    for(var i =0; i<js.length; i++) {
      var msg = jsonToMessage(js[i]);
      _chats.add(msg);
      newMessageCount++;
    }

    _boardSubject.add(_chats);

    return newMessageCount;
  }

  /*
    초기 chatRoomId의 모든 메시지 불러오기(max: 100개 or 7일전까지)
   */
  initialFetch(String currentId, {String roomId, String otherId}) async {
    if(WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
      _brightness = 'dark';
    } else {
      _brightness = 'light';
    }

    print('--------- initialFetch() -----------');
    currentUserId = currentId;
    chatRoomId = roomId;
    otherUserId = otherId;
    print('chatRoomId: ${chatRoomId}');
    var res = await request.post(chatFetchaAllUrl, body: {
      //'brightness': _brightness,
      'chat_room_id': chatRoomId,
      'other_mb_id': otherUserId,
    });

    print('---------  result --------');
    print(res.statusCode);
    print(res.content());

    var js = res.json();
    //print(js);
    if (js['chat_room_id'] != null) {
      chatRoomId = js['chat_room_id'];

      for (var i = 0; i < js['messages'].length; i++) {
        print(js['messages'][i]['createdAt']);
        var msg = jsonToMessage(js['messages'][i]);
        _chats.add(msg);
      }
      print(_chats[0].createdAt);
      _boardSubject.add(_chats);
      print('end initial fetch');
    } else {
      print('${otherUserId}와 채팅한 적이 없습니다. ');
    }


  }

  Map<String, Color>getMessageColor(String mb_id) {
    Map<String, Color> colors;
    if(WidgetsBinding.instance.window.platformBrightness == Brightness.light) {
      colors = (mb_id == currentUserId) ? {
        'boxColor': Colors.cyan,
        'textColor': Colors.black
      } : {
        'boxColor': Colors.white,
        'textColor': Colors.black
      };
      
    } else {
      colors = (mb_id == currentUserId) ? {
        'boxColor': Colors.cyan,
        'textColor': Colors.black
      } : {
        'boxColor': Colors.white,
        'textColor': Colors.black
      };
    }

    return colors;
  }

  ChatMessage jsonToMessage(Map<String, dynamic> js) {

    var colors = getMessageColor(js['user']['uid']);
    var msg = ChatMessage(
        id: js['id'],
        text: js['text'],
        image: js['image'],
        video: js['video'],
        createdAt: DateTime.parse(js['createdAt']),

        user: ChatUser(
          uid: js['user']['uid'],
          name: js['user']['name'],
          avatar: js['user']['avatar'],
          //containerColor: js['containerColor'],
          //color: js['color'],
          containerColor: colors['boxColor'],
          color: colors['textColor'],
        ),
        quickReplies: js['quickReplies']
    );
    print('chatMessage: ${msg.user.containerColor}');
    return msg;
  }

}