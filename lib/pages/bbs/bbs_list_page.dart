
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_detail_page.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_register_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_profile_register_page.dart';
import 'package:provider/provider.dart';




class BbsListPage extends StatefulWidget {
  int count = 1;
  @override
  _BbsListPageState createState() => _BbsListPageState();
}

class _BbsListPageState extends State<BbsListPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {

    //var board = Provider.of<BoardProvider>(context);
    var count = 0;

    boardBloc.fetch('mico_qna');


    return Scaffold(
      appBar: AppBar(

        //centerTitle: true,
        title: Text('미용코칭몬 ${widget.count} ${this.count} ${count}', style: TextStyle(
            fontSize: 13.0
        ),),

        //flexibleSpace: FlexibleSpaceBar(title: Text(''),),
        //titleSpacing: EdgeInsets.all(0.0),

        actions: <Widget>[
          FlatButton(
              child: Text('설정'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TeacherProfileRegisterPage()));
                //MaterialPageRoute(builder: (_) => TestPage()));
              }
          ),
          FlatButton(
            child: Text('강사등록'),
            onPressed: () =>

                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TeacherProfileRegisterPage())),
          ),
          //currentUser.data.mb_id == '' ? _buildLogin(context) : _buildLogout(context),

        ],
      ),


      body: Container(
        child: StreamBuilder(
          stream: boardBloc.data,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data.length > 0) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = snapshot.data[index];
                  return _buildPost(context, post);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 0.5,
                    color: Colors.grey,
                  );
                },
              );
            } else {
              return Text('게시글이 없습니다.');
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        mini: true,
        onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (_) => BbsRegisterPage()));
        },
      ),
    );
  }

  _buildPost(BuildContext context, Post post) {
    return GestureDetector(
      onTap: () {
        this.count++;
        Navigator.push(context, MaterialPageRoute(builder: (_) => BbsDetailPage(post: post) ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(post.wr_subject),
            Text(post.wr_datetime),
          ],
        ),
      )
    );
  }
}
