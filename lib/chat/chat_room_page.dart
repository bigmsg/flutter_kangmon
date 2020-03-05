import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/chat/model/chat_message_bloc.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/data/transparent_image.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_detail_page.dart';
import 'package:flutter_kangmon/widgets/alert_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:provider/provider.dart';
import 'package:flutter_kangmon/data/transparent_image.dart';

class ChatRoomPage extends StatefulWidget {
  String currentUserId;
  String otherUserId;

  Lesson lesson;

  ChatRoomPage({this.currentUserId, this.otherUserId, this.lesson});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();
  ChatMessageBloc chatMessagBloc = ChatMessageBloc();



  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();


  Timer timer;


  var i = 0;

  @override
  void initState() {
    print('-- initState ---');
    print('widget.otherUserId: ${widget.otherUserId}');
    if (widget.currentUserId != '' && widget.currentUserId != widget.otherUserId) {
      chatMessagBloc.initialFetch(widget.currentUserId, widget.otherUserId);
    }
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      /*if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }*/
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent + 20,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }


  // 메시지 전송
  void onSend(ChatMessage message) {
    print('--- 전송버튼 클릭 ---');
    print(message.toJson());
    chatMessagBloc.sendMessage(message);
    if (i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    } else {
      systemMessage();
    }
  }

  @override
  Widget build(BuildContext context) {

    var currentUser = Provider.of<CurrentUser>(context, listen: false);

    print('hello');
        //showAlertDialog(context, '1회원전용', '회원 또는 다른 강의에 상담가능합니다.');

    Timer(Duration(milliseconds: 500), () async {
      var msg = '';
      if(currentUser.data.mb_id == '')
          msg = '로그인하여주세요.';
      if(currentUser.data.mb_id == widget.otherUserId)
          msg = '본인레슨에 상담할 수 없습니다.';

      if(msg != ''){
        await showAlertDialog(context, '❌ 레슨상담불가', msg);
        Navigator.pop(context);

      }

    });



    final ChatUser user = ChatUser(
      name: currentUser.data.mb_nick,
      uid: currentUser.data.mb_id,
      avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
    );

    // input bottom bar 색상 설정
    Color inputBoxColor;
    Color inputTextColor;
    Color roomBackgroundColor = Color.fromRGBO(165, 80, 80, 1);
    if(WidgetsBinding.instance.window.platformBrightness == Brightness.light) {
      inputBoxColor = Color.fromRGBO(230, 230, 230, 1);
      inputTextColor = Colors.black;
    } else {
      inputBoxColor = Color.fromRGBO(20, 20, 20, 1);
      inputTextColor = Colors.white;
    }

    // 5초마다 업데이트 하기
    timer = Timer.periodic(Duration(milliseconds: 5000), (_) => _refresh());

    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    print('-------------- statusbar height --------');
    print(statusbarHeight);

    return Scaffold(
      appBar: AppBar(
        title: widget.lesson != null ? Text('레슨명: ${widget.lesson.wr_subject}') : Text('챗방'),

      ),
      body: StreamBuilder(
          stream: chatMessagBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                //child: Text('데이터가 없습니다.', style: TextStyle(fontSize: 16),),
              );
            } else {

              var messages = snapshot.data;
              return Container(
                decoration: BoxDecoration(
                  /*image: DecorationImage(
                      image: AssetImage('assets/images/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),*/
                  color: roomBackgroundColor,
                ),
                child: DashChat(
                  key: _chatViewKey,
                  inverted: false,
                  onSend: onSend,
                  user: user,
                  inputDecoration:
                  InputDecoration.collapsed(hintText: "메시지"),
                  dateFormat: DateFormat('yyyy-MM-dd'),
                  timeFormat: DateFormat('HH:mm'),
                  //timeFormat: DateFormat('yyyy-MM-dd HH:mm'),
                  messages: messages,
                  avatarBuilder: (user) => _buildAvatar(context, user),
                  //messageTimeBuilder: (datetime) => _buildMessageTime(context, datetime),
                  /*messageBuilder: (msg) {
                    // 말풍선도 그려넣어야 함
                    return Text(msg.text, style: TextStyle(
                      fontSize: 16
                    ),);
                  },*/
                  /*messageTextBuilder: (text) {
                    // 글자색상도 정해야 하고 나, 타인이 모두 같은 글자색이 됨
                    return Text(text, style: TextStyle(
                      fontSize: 16,
                      color: Colors.pink
                    ),);
                  },*/
                  /*messageContainerDecoration: BoxDecoration(
                    color: Colors.white12
                  ),*/
                  /*sendButtonBuilder: (msg) {
                    return IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        onSend();
                      },
                    );
                  },*/

                  showUserAvatar: false,
                  showAvatarForEveryMessage: false,
                  scrollToBottom: false, // bottom 으로가는 버튼없애기(light 모드에서 하얗게 나옴)
                  //scrollToBottom: true,
                  onPressAvatar: (ChatUser user) {
                    print("OnPressAvatar: ${user.name}");
                  },
                  onLongPressAvatar: (ChatUser user) {
                    print("OnLongPressAvatar: ${user.name}");
                  },
                  inputMaxLines: 5,
                  messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                  alwaysShowSend: true,
                  inputTextStyle: TextStyle(fontSize: 16.0, color: inputTextColor),
                  inputContainerStyle: BoxDecoration(
                    border: Border.all(width: 0.0),
                    color: inputBoxColor,
                    //color: Colors.pink,
                  ),
                  onQuickReply: (Reply reply) {
                    setState(() {
                      messages.add(ChatMessage(
                          text: reply.value,
                          createdAt: DateTime.now(),
                          user: user));
                      messages = [...messages];
                    });

                    Timer(Duration(milliseconds: 300), () {
                      _chatViewKey.currentState.scrollController
                        ..animateTo(
                          _chatViewKey.currentState.scrollController.position
                              .maxScrollExtent,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );

                      if (i == 0) {
                        systemMessage();
                        Timer(Duration(milliseconds: 600), () {
                          systemMessage();
                        });
                      } else {
                        systemMessage();
                      }
                    });
                  },
                  onLoadEarlier: () {
                    print("laoding...");
                  },
                  shouldShowLoadEarlier: false,
                  showTraillingBeforeSend: true,
                  /*trailing: <Widget>[
                    IconButton(
                      color: Colors.green,
                      icon: Icon(Icons.photo),
                      onPressed: () async {
                        print('이미지 선택 버튼 클릭');
                        File result = await ImagePicker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                          maxHeight: 400,
                          maxWidth: 400,
                        );

                        if (result != null) {

                        }
                      },
                    )
                  ],*/
                ),
              );
            }
          }),
    );
  }

  //5초마다 갱신
  _refresh() {
    if (widget.currentUserId != '' && widget.currentUserId != widget.otherUserId) {
      chatMessagBloc.intervalFetch().then((count) {
        if (count > 0) {
          if (i == 0) {
            systemMessage();
            Timer(Duration(milliseconds: 600), () {
              systemMessage();
            });
          } else {
            systemMessage();
          }
        }
      });
    }

  }

  _buildMessageTime (BuildContext context, String datetime) {
    print('---------- bulid time ---------');
    print(datetime);
    var date = DateTime.parse(datetime);
    var time = '';
    if(DateFormat('yyyy-MM-dd').format(DateTime.now()) == DateFormat('yyyy-MM-dd').format(date)) {
      time = DateFormat("HH:mm").format(date);
    } else {
      time = DateFormat("HH:mm").format(date);
    }
    return Text(time, style: TextStyle(
      color: Colors.black,
          fontSize: 10,
    ),);
  }

  _buildAvatar(BuildContext context, ChatUser user) {
    return GestureDetector(
      //onTap: () => onPress(user),
      //onLongPress: () => onLongPress(user),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Positioned(
            left: -5, bottom: 5,
            child: ClipOval(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.08,
                width: MediaQuery.of(context).size.width * 0.08,
                color: Colors.grey,
                child: Center(child: Text(user.name[0])),
              ),
            ),
          ),
          user.avatar != null && user.avatar.length != 0
              ? Container(
            height: MediaQuery.of(context).size.width * 0.08,
            width: MediaQuery.of(context).size.width * 0.08,
            //padding: EdgeInsets.only(left: -10),
            //left: -20,
            child: Stack(
              alignment: Alignment.topLeft,
              overflow: Overflow.visible,
              children: <Widget>[

                Positioned(
                  left: -5,
                  bottom: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.memoryNetwork(
                          image: user.avatar,
                          placeholder: kTransparentImage,
                          //placeholder: AssetImage('assets/images/no-image.jpg'),
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.width * 0.1,
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                    ),
                ),

                //SizedBox(height: 20,),
                Positioned( // 버튼
                  left: -5,
                  bottom: -16,
                  child: Text(user.name, style: TextStyle(
                    fontSize: 10
                  ),)
                ),

              ],
            ),
          )
              : Container()
        ],
      ),
    );
  }

}