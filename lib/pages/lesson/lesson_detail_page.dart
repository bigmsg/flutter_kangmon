import 'package:flutter/material.dart';
import 'package:flutter_kangmon/chat/chat_room_page.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_comment_register_page.dart';
import 'package:flutter_kangmon/widgets/alert_widget.dart';
import 'package:provider/provider.dart';


class LessonDetailPage extends StatefulWidget {
  Lesson lesson;
  LessonDetailPage({this.lesson});

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    Post post;
    if(widget.lesson != null) {
      post = Post(
        mb_id: widget.lesson.mb_id,
        mb_nick: widget.lesson.mb_nick,
        wr_id: widget.lesson.wr_id,
        wr_subject: widget.lesson.wr_subject,
        wr_content: widget.lesson.wr_content,
        is_comment: false,
        wr_datetime: widget.lesson.wr_datetime,
        wr_photo: null,
      );
    }




    return Scaffold(
        bottomSheet: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, -1),
                    blurRadius: 6.0
                )
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text('레슨문의'),
                  onPressed: () =>_onChatPage(context),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image(
                      height: MediaQuery.of(context).size.width*4/7,  // 7(375px):5(267px)
                      width: MediaQuery.of(context).size.width, // 375(iPhone6s)
                      image: (widget.lesson.wr_photos.length > 0 && widget.lesson.wr_photos[0] != null) ? NetworkImage(widget.lesson.wr_photos[0]) :  AssetImage('assets/images/no-image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  //),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite),
                          color: Colors.red,
                          iconSize: 30.0,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(widget.lesson.wr_subject, textAlign: TextAlign.left,),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Row(
                      children: <Widget>[
                        Text('금액: ${widget.lesson.wr_price}원',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepOrange
                          ),
                          textAlign: TextAlign.left,),
                        SizedBox(width: 10,),
                        Text('지역: ${widget.lesson.wr_local}', textAlign: TextAlign.left,),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Row(
                      children: <Widget>[
                        Text(widget.lesson.wr_content, textAlign: TextAlign.left,),
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        )
    );
  }

  _onChatPage(BuildContext context) async {
    var currentUser = Provider.of<CurrentUser>(context, listen: false);
    Navigator.push(context,
        MaterialPageRoute(builder: (_) =>
            ChatRoomPage(
              currentUserId: currentUser.data.mb_id,
              otherUserId: widget.lesson.mb_id,
              lesson: widget.lesson,
            ))
    );
  }
}
