import 'package:flutter/material.dart';
import 'package:flutter_kangmon/models/lesson.dart';


class BbsRegisterPage extends StatefulWidget {

  Post post;

  BbsRegisterPage({this.post});


  @override
  _BbsRegisterPageState createState() => _BbsRegisterPageState();
}

class _BbsRegisterPageState extends State<BbsRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( (widget.post == null) ? '댓글등록': widget.post.wr_subject ),
      ),
      body: Text('uouoe'),
    );
  }
}
