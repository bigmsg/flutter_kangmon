import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:provider/provider.dart';


class BbsRegisterPage extends StatefulWidget {

  Post post;

  BbsRegisterPage({this.post});

  @override
  _BbsRegisterPageState createState() => _BbsRegisterPageState();
}

class _BbsRegisterPageState extends State<BbsRegisterPage> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( (widget.post == null) ? '게시글 작성': widget.post.wr_subject ),
      ),
      body:_buildWrite(),
    );
  }

  // 새글, 수정하기
  _buildWrite() {
    _subjectController.text = widget.post != null ? widget.post.wr_subject : null;
    _contentController.text = widget.post != null ? widget.post.wr_content : null;

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 15,),
          //Text('wr_id: ${widget.post.wr_id}'),
          SizedBox(height: 15,),

          TextField(
            controller: _subjectController,
            decoration: InputDecoration(
                border: OutlineInputBorder(

                ),
                labelText: "제목"
            ),
          ),
          SizedBox(height: 10,),

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
                  color: Colors.black54,
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
      'w': widget.post == null ? '': 'u',
      'wr_id': widget.post == null ? '' : widget.post.wr_id,
      'wr_subject': _subjectController.text,
      'wr_content': _contentController.text,
    };
    var res = await request.post(bbsUpdateUrl, body: params);
    print(res.content());

    Navigator.pop(context);
    if(widget.post != null)
      Navigator.pop(context);
  }
}
