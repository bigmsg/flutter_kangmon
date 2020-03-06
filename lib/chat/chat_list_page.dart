import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/chats_bloc.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:provider/provider.dart';

import 'chat_room_page.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {

    chatsBloc.fetch();

    return Scaffold(
      appBar: AppBar(
        title: Text('채팅상담 목록'),
      ),
      body: StreamBuilder(
        stream: chatsBloc.data,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data.length > 0) {
            return _buildChatList(context, snapshot.data);
          } else {
            return Center(
                child: Text('상당목록이 없습니다.')
            );
          }
        }
      ),
    );
  }

  Widget _buildChatList(BuildContext context, List<Chat> data) {

    return ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          Chat chat = data[index];
          String lastDate = getDateString(data[index].lastDatetime);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _onChatPage(context, data[index].roomId);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(chat.roomName, style: TextStyle(
                        fontSize: 16
                      ),),
                      SizedBox(width: 8,),
                      Text(chat.lastMessage, style: TextStyle(
                          fontSize: 16
                      ),),
                    ],
                  ),

                  chat.newMessageCount != 0 ? Column(
                    children: <Widget>[
                      Text('${chat.newMessageCount}개', style: TextStyle(
                          fontSize: 16
                      ),),
                      Text(lastDate, style: TextStyle(
                          fontSize: 16
                      ),),
                    ],
                  )
                  : Text(lastDate, style: TextStyle(
                      fontSize: 16
                    ),),

                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0.5,
            color: Colors.grey,
          );
        },
    );

  }

  String getDateString(DateTime lastDatetime) {
    String result;
    if(DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(lastDatetime)) {
      result = DateFormat("HH:mm").format(lastDatetime);
    } else {
      result = DateFormat("MM/dd HH:mm").format(lastDatetime);
    }
    return result;
  }

  _onChatPage(BuildContext context, String roomId) {
    var currentUser = Provider.of<CurrentUser>(context, listen: false);
    Navigator.push(context,
        MaterialPageRoute(builder: (_) =>
            ChatRoomPage(
              currentUserId: currentUser.data.mb_id,
              chatRoomId: roomId,
            ))
    );
  }
}
