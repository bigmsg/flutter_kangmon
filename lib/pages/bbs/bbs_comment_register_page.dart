import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';

class BbsCommentRegisterPage extends StatefulWidget {

  Post post;
  String w;

  BbsCommentRegisterPage({this.post, this.w});

  @override
  _BbsCommentRegisterPageState createState() => _BbsCommentRegisterPageState();
}

class _BbsCommentRegisterPageState extends State<BbsCommentRegisterPage> {

  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.w == null ? widget.post.wr_subject : '댓글수정'),
      ),
      body: _buildWrite(),
    );
  }

  // 새댓글, 수정
  _buildWrite() {
    if (widget.post != null && widget.w == 'cu') {
      _contentController.text = widget.post.wr_content;
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 15,),
          Text('wr_id: ${widget.post.wr_id}, w: ${widget.w}'),

          TextField(
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "내용"
            ),
          ),
          SizedBox(height: 10,),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: RaisedButton(
              child: Text(
                "저장하기",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              color: Colors.yellow,
              onPressed: () => _onSubmit(context),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }


  _onSubmit(BuildContext context) async {

    var params = {
        'bo_table': 'mico_qna',
        'w': widget.w,
        'wr_id': widget.post.wr_id,       // parent_id
        'comment_id': widget.w == 'cu' ? widget.post.wr_id : '',  // 자신 댓글 comment_id
        'wr_content': _contentController.text
    };

    await request.post(bbsCommentUpdateUrl, body: params);
    //print(res.content());

    Navigator.pop(context);


  }

}
