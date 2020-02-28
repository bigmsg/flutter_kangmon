import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_detail_page.dart';
import 'package:flutter_kangmon/pages/bbs/bbs_register_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_profile_register_page.dart';




class BbsListPage extends StatefulWidget {
  @override
  _BbsListPageState createState() => _BbsListPageState();
}

class _BbsListPageState extends State<BbsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        //centerTitle: true,
        title: Text('미용코칭몬', style: TextStyle(
            fontSize: 13.0
        ),),

        flexibleSpace: FlexibleSpaceBar(title: Text(''),),
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
        child: ListView.separated(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            Post post = posts[index];
            return _buildPost(context, post);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 0.5,
              color: Colors.grey,
            );
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
