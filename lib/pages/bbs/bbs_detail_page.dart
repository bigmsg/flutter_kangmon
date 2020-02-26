import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_register_page.dart';


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
                child: Text('답글을 남기세요'),
              ),
            ],
          ),

          _buildComment(context),
          SizedBox(height: 100,),

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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BbsRegisterPage(post: widget.post,)));
                },
              ),
            ],
          ),
        ),
      ),

    );

  }

  _buildComment(BuildContext context) {
    comments.forEach((post) {
      print(post.wr_subject);
    });
    return Text(comments[2].wr_subject);
  }
}
