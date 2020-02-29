import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_register_page.dart';

import 'bbs_comment_register_page.dart';


class BbsDetailPage extends StatefulWidget {
  Post post;

  BbsDetailPage({this.post});

  @override
  _BbsDetailPageState createState() => _BbsDetailPageState();
}

class _BbsDetailPageState extends State<BbsDetailPage> {

  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.wr_subject),
        actions: <Widget>[
          FlatButton(
            child: Text(widget.post.mb_nick,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,

              ),
            ),
            //onPressed: () {},
          ),

        ],
      ),
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
                child: Text('댓글을 남겨주세요'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BbsCommentRegisterPage(post: widget.post, w: 'c')));
                },
              ),
            ],
          ),
        ),
      ),

      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text(widget.post.wr_content,)
          ),

          Divider(
            height: 0.5,
            color: Colors.grey,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: <Widget> [
                    Icon(Icons.photo),
                    SizedBox(width: 5,),
                    Text('게시글 수정'),
                  ]
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BbsRegisterPage(post: widget.post)));
                },
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildListComment(context),
          ),
          SizedBox(height: 100,),

        ],
      ),


    );

  }

  _buildListComment(BuildContext context) {
    List<Widget> commentList = [];
    comments.forEach((comment) {
      var tmp = Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Expanded(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 5,),
                    Text(comment.wr_content, style: TextStyle(
                      fontSize: 12.0,
                    ),),
                  ],
                ),
              ),
              //Text(comment.mb_id),

              FlatButton(
                child: Text('수정하기'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BbsCommentRegisterPage(post: comment, w: 'cu')));
                },
              ),
            ],
          ),
      );
      commentList.add(tmp);

    });
    return commentList;
    //return Text(comments[2].wr_subject);
  }
}
